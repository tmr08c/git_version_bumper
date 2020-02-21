# frozen_string_literal: true

require 'spec_helper'
require 'git'
require 'git_version_bumper/version_bumper/tag'

describe GitVersionBumper::VersionBumper::Tag do
  describe '.current' do
    context 'when there are no tags' do
      it 'start with version 0.0.0' do
        with_repo do
          git_object = Git.open('./')
          current_tag = described_class.current(git_object)

          expect(current_tag.to_s).to eq 'v0.0.0'
        end
      end
    end

    context 'when there are tags' do
      context 'when there is only one version tag' do
        it 'returns the single version tag' do
          with_repo do
            tag('v1.0.0')
            git_object = Git.open('./')

            current_tag = described_class.current(git_object)

            expect(current_tag.to_s).to eq 'v1.0.0'
          end
        end
      end

      context 'when there are multiple version tags' do
        it 'returns the highest version' do
          with_repo do
            tag('v0.0.9')
            tag('v0.0.10')
            tag('v0.0.11')

            git_object = Git.open('./')

            current_tag = described_class.current(git_object)

            expect(current_tag.to_s).to eq 'v0.0.11'
          end
        end
      end
    end
  end

  describe '.from_name' do
    it 'can map a version string formatted like "vX.Y.Z"' do
      tag = described_class.from_name('v1.2.3')

      expect(tag.major).to eq(1)
      expect(tag.minor).to eq(2)
      expect(tag.patch).to eq(3)
    end
  end

  describe '#<=>' do
    describe '#>' do
      it 'compares major, minor, and patch' do
        expect(described_class.new(2, 3, 4) > described_class.new(0, 0, 1))
          .to be_truthy
        expect(described_class.new(2, 3, 4) > described_class.new(0, 5, 6))
          .to be_truthy
        expect(described_class.new(2, 3, 4) > described_class.new(1, 2, 3))
          .to be_truthy

        expect(described_class.new(2, 3, 4) > described_class.new(2, 3, 5))
          .to be_falsey
        expect(described_class.new(2, 3, 4) > described_class.new(2, 4, 0))
          .to be_falsey
        expect(described_class.new(2, 3, 4) > described_class.new(3, 0, 0))
          .to be_falsey

        expect(described_class.new(2, 3, 4) > described_class.new(2, 3, 4))
          .to be_falsey
      end
    end

    describe '#<' do
      it 'compares major, minor, and patch' do
        expect(described_class.new(2, 3, 4) < described_class.new(2, 3, 5))
          .to be_truthy
        expect(described_class.new(2, 3, 4) < described_class.new(3, 0, 0))
          .to be_truthy
        expect(described_class.new(2, 3, 4) < described_class.new(2, 4, 0))
          .to be_truthy

        expect(described_class.new(2, 3, 4) < described_class.new(0, 0, 1))
          .to be_falsey
        expect(described_class.new(2, 3, 4) < described_class.new(0, 5, 6))
          .to be_falsey
        expect(described_class.new(2, 3, 4) < described_class.new(1, 2, 3))
          .to be_falsey

        expect(described_class.new(2, 3, 4) < described_class.new(2, 3, 4))
          .to be_falsey
      end
    end

    describe '#==' do
      it 'compares major, minor, and patch' do
        expect(described_class.new(2, 3, 4) == described_class.new(2, 3, 4))
          .to be_truthy

        expect(described_class.new(2, 3, 4) == described_class.new(2, 3, 5))
          .to be_falsey
        expect(described_class.new(2, 3, 4) == described_class.new(3, 0, 0))
          .to be_falsey
        expect(described_class.new(2, 3, 4) == described_class.new(2, 4, 0))
          .to be_falsey

        expect(described_class.new(2, 3, 4) == described_class.new(0, 0, 1))
          .to be_falsey
        expect(described_class.new(2, 3, 4) == described_class.new(0, 5, 6))
          .to be_falsey
        expect(described_class.new(2, 3, 4) == described_class.new(1, 2, 3))
          .to be_falsey
      end
    end
  end

  def tag(tag_name)
    `git commit --message='test commit' --allow-empty`
    `git tag -a #{tag_name} -m '#{tag_name}'`
  end
end

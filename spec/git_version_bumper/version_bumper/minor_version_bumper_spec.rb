# frozen_string_literal: true

require 'spec_helper'
require 'git_version_bumper/version_bumper/minor_version_bumper'

describe GitVersionBumper::VersionBumper::MinorVersionBumper do
  describe '#bump' do
    describe 'commit message' do
      let(:repo_path) { '/tmp/repo' }

      subject { described_class.new(repo_path) }

      it 'should create a "Version Bump" commit' do
        with_repo(repo_path) do
          commit_list = `git log`
          expect(commit_list).to be_empty

          subject.bump

          commit_list = `git log`
          expect(commit_list).to match(/Version Bump/)
        end
      end
    end

    context 'when there are no existing tags' do
      let(:repo_path) { '/tmp/noTagRepo' }

      subject { described_class.new(repo_path) }

      it 'should create a v0.1.0 tag' do
        with_repo(repo_path) do
          tag_list = `git tag -l`
          expect(tag_list).to be_empty

          subject.bump

          tag_list = `git tag -l`
          expect(tag_list).to match(/v0.1.0/)
        end
      end

      context 'when there are existing tags' do
        let(:repo_path) { '/tmp/taggedRepo' }

        subject { described_class.new(repo_path) }

        it 'should increase the minor version tag' do
          with_repo(repo_path) do
            `git commit --allow-empty -m 'commit'`
            `git tag 'v1.2.3'`

            subject.bump

            tag_list = `git tag -l`
            expect(tag_list).to match(/v1.3.0/)
          end
        end
      end
    end
  end
end

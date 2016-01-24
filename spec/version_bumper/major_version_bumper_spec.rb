require 'versionify/version_bumper/major_version_bumper'
require 'spec_helper'

describe Versionify::VersionBumper::MajorVersionBumper do
  describe '.bump' do
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

      it 'should create a v1.0.0 tag' do
        with_repo(repo_path) do
          tag_list = `git tag -l`
          expect(tag_list).to be_empty

          subject.bump

          tag_list = `git tag -l`
          expect(tag_list).to match(/1.0.0/)
        end
      end
    end
  end
end

def with_repo(path = 'tmp/testRepo')
  FileUtils.mkdir_p(path)
  FileUtils.chdir(path)
  `git init`

  yield

  FileUtils.rm_rf(path)
  FileUtils.chdir(File.realpath("#{__FILE__}/.."))
end
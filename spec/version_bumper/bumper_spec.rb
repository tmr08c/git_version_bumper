require 'versionify'
require 'versionify/version_bumper/bumper'

describe Versionify::VersionBumper::Bumper do
  describe '.new' do
    context 'when the path given is not a repo' do
      it 'should raise an exception' do
        expect { described_class.new('') }
          .to raise_error(Versionify::Errors::NotRepositoryError)
      end
    end
  end

  describe '#bump' do
    let(:repo_path) { '/tmp/repo' }

    subject { described_class.new(repo_path) }

    it 'should have to be implemented in a child class' do
      with_repo(repo_path) do
        expect { subject.bump }.to raise_error(NotImplementedError)
      end
    end
  end
end

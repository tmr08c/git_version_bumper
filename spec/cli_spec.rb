require 'versionify'
require 'spec_helper'

describe Versionify::CLI do
  describe '#run' do
    context "when the directroy isn't a repositroy" do
      subject { described_class.new }

      before do
        FileUtils.chdir('/tmp')
      end

      it 'should return an error exit status' do
        expect(subject.run).to eq 1
      end

      it 'give an error message' do
        expect { subject.run }.to output(/repository/).to_stderr
      end

      after do
        FileUtils.chdir(File.realpath("#{__FILE__}/.."))
      end
    end

    context 'when the repo is a repository' do
      subject { described_class.new }

      before do
        path = '/tmp/testRepo'
        FileUtils.mkdir_p(path)
        FileUtils.chdir(path)
        %x(git init)
      end

      it 'should return a successful exit status' do
        expect(subject.run).to eq 0
      end

      after do
        FileUtils.chdir(File.realpath("#{__FILE__}/.."))
      end
    end
  end
end

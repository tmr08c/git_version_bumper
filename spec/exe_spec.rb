require 'versionify'
require 'spec_helper'

describe 'bundle executable' do
  it 'should use the CLI class' do
    allow(Versionify::CLI).to receive(:start)
    output = versionify ''
    puts output
    expect(Versionify::CLI).to have_received(:start)
  end

  context 'when asking for help' do
    it 'should list the bump TYPE options' do
      expect { versionify 'help bump' }.to output(/MAJOR/).to_stdout
      expect { versionify 'help bump' }.to output(/MINOR/).to_stdout
      expect { versionify 'help bump' }.to output(/DOT/).to_stdout
    end
  end

  context 'when not passing in a type' do
    it 'should say a type is resquired' do
      expect { versionify 'bump' }.to output(/ERROR/).to_stderr
    end
  end

  context 'when passing in a type' do
    context 'when that type is not a valid option' do
    end

    context 'when that type is a valid options' do
      context 'when the directory is not a repo' do
        before do
          FileUtils.chdir('/tmp')
        end

        it 'should return an error status message' do
          versionify 'bump'
          expect($?.exitstatus).to_not be_zero
        end
      end

      context 'when the directory is a repo' do
        before do
          FileUtils.mkdir_p('/tmp/testRepo')
          FileUtils.chdir('/tmp/testRepo')
          %x(git init)
        end

        it 'should have a successful exit status' do
          versionify 'bump'

          expect($?.exitstatus).to be_zero
        end

        let(:cli) { instance_double(Versionify::CLI.new) }

        it 'should pass command line arguments to the Versionify::CLI class' do
          versionify 'fist bump'

          expect(Versionify::CLI).to receive(:new).and_return(cli)
          expect(cli).to receive(:fist).with(:bump)
        end

        after do
          FileUtils.rm_rf('/tmp/testRepo/')
          FileUtils.chdir(File.realpath("#{__FILE__}/.."))
        end
      end
    end
  end
end

def versionify(command)
  path = File.realpath("#{__FILE__}/../../bin")

  puts path
  output = `#{path}/versionify #{command}`
end
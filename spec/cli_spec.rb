require 'spec_helper'
require 'debugger'

describe 'bundle executable' do
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

    after do
      FileUtils.rm_rf('/tmp/testRepo/')
      FileUtils.chdir(File.realpath("#{__FILE__}/.."))
    end
  end
end

def versionify(command)
  path = File.realpath("#{__FILE__}/../../bin")

  %x(#{path}/versionify #{command})
end

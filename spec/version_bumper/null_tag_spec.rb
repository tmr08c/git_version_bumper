require 'spec_helper'
require 'git_version_bumper/version_bumper/null_tag'

describe GitVersionBumper::VersionBumper::NullTag do
  describe '#name' do
    subject { described_class.new }

    it 'return version 0' do
      expect(subject.name).to eq 'v0.0.0'
    end
  end
end

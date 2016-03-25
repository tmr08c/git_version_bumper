require 'git_version_bumper/version_bumper/unknown_type_version_bumper'
require 'spec_helper'

describe GitVersionBumper::VersionBumper::UnknownTypeVersionBumper do
  describe '#bump' do
    it 'should raise an InvalidVersionBumpType exception' do
      unknown_type_version_bumper = described_class.new

      expect { unknown_type_version_bumper.bump }.
        to raise(GitVersionBumper::VersionBumperErrors::InvalidVersionBumpType)
    end
  end
end

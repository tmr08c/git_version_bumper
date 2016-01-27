require 'git_version_bumper'
require 'git_version_bumper/version_bumper/bumper'
require 'git_version_bumper/version_bumper/null_tag'
require 'git'

module GitVersionBumper
  module VersionBumper
    class MajorVersionBumper < Bumper

      private

      def tag
        git.add_tag("v#{current_major_version + 1}.0.0")
      end
    end
  end
end

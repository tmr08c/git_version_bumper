require 'git_version_bumper'
require 'git_version_bumper/version_bumper/bumper'

module GitVersionBumper
  module VersionBumper
    class MinorVersionBumper < Bumper
      private

      def tag
        git.add_tag("v#{current_major_version}.#{current_minor_version + 1}.0")
      end
    end
  end
end

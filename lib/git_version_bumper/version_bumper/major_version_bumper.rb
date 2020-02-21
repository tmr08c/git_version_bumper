# frozen_string_literal: true

require 'git_version_bumper/version_bumper/bumper'

module GitVersionBumper
  module VersionBumper
    # Implementation of Bumper that increases the major version number.
    class MajorVersionBumper < Bumper
      private

      def tag
        git.add_tag("v#{current_major_version + 1}.0.0")
      end
    end
  end
end

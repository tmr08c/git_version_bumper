require 'versionify'
require 'versionify/version_bumper/bumper'

module Versionify
  module VersionBumper
    class MinorVersionBumper < Bumper
      private

      def tag
        git.add_tag("v#{current_major_version}.#{current_minor_version + 1}.0")
      end
    end
  end
end

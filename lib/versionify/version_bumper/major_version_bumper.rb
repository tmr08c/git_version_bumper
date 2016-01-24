require 'versionify'
require 'versionify/version_bumper/bumper'
require 'versionify/version_bumper/null_tag'
require 'git'

module Versionify
  module VersionBumper
    class MajorVersionBumper < Bumper

      private

      def tag
        git.add_tag("v#{current_major_version + 1}.0.0")
      end
    end
  end
end

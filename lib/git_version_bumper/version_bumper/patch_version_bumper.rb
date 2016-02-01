require 'git_version_bumper/version_bumper/bumper'

module GitVersionBumper
  module VersionBumper
    class PatchVersionBumper < Bumper
      private

      def tag
        git.add_tag(
          "v#{current_major_version}." \
          "#{current_minor_version}." \
          "#{current_patch_version + 1}"
        )
      end
    end
  end
end

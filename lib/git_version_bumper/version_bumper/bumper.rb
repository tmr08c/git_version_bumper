require 'git_version_bumper'
require 'git_version_bumper/version_bumper/null_tag'
require 'git'

module GitVersionBumper
  module VersionBumper
    # Parent class used for housing logic on how to handle increasing version
    # number. This includes creating and tagging a version bump commit.
    #
    # This should be inheirted from to implement the logic for creating the
    # `tag` associated with the new version.
    class Bumper
      VERSION_BUMP_COMMIT_MESSAGE = 'Version Bump.'.freeze

      def initialize(path)
        @git = git_object(path)
      end

      def bump
        commit
        tag
        update_file(project_type)
      end

      private

      attr_reader :git

      def commit
        git.commit(VERSION_BUMP_COMMIT_MESSAGE, allow_empty: true)
      end

      def tag
        fail NotImplementedError
      end

      def current_version
        @current_version ||= current_tag.name.sub('v', '')
      end

      def current_tag
        @current_tag ||=
          git.tags.last || VersionBumper::NullTag.new
      end

      def current_major_version
        @current_major_version ||= Integer(current_version.split('.').first)
      end

      def current_minor_version
        @current_minor_version ||= Integer(current_version.split('.')[1])
      end

      def current_patch_version
        @current_patch_version ||= Integer(current_version.split('.').last)
      end

      def git_object(path)
        Git.open(path)
      rescue ArgumentError
        raise Errors::NotRepositoryError
      end
    end
  end
end

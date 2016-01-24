require 'versionify'
require 'versionify/version_bumper/null_tag'
require 'git'

module Versionify
  module VersionBumper
    class MajorVersionBumper
      VERSION_BUMP_COMMIT_MESSAGE = 'Version Bump.'.freeze

      def initialize(path)
        @git = git_object(path)
      end

      def bump
        commit
        tag
      end

      private

      attr_reader :git

      def commit
        git.commit(VERSION_BUMP_COMMIT_MESSAGE, allow_empty: true)
      end

      def tag
        git.add_tag("v#{current_major_version + 1}.0.0")
      end

      def current_major_version
        @current_major_version ||= Integer(current_version.split('.').first)
      end

      def current_version
        @current_version ||= current_tag.name.sub('v', '')
      end

      def current_tag
        @current_tag ||=
          git.tags.last || Versionify::VersionBumper::NullTag.new
      end

      def git_object(path)
        Git.open(path)
      rescue ArgumentError
        fail Versionify::NotRepositoryError
      end
    end
  end
end

require 'versionify'
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
        git.add_tag('1.0.0')
      end

      def git_object(path)
        Git.open(path)
      rescue ArgumentError
        fail Versionify::NotRepositoryError
      end
    end
  end
end

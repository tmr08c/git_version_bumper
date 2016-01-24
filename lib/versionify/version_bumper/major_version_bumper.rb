require 'versionify'
require 'git'

module Versionify
  module VersionBumper
    class MajorVersionBumper
      def initialize(path)
        @git = git_object(path)
      end

      def bump
        git.commit('Version Bump', allow_empty: true)
        git.add_tag('1.0.0')
      end

      private

      attr_reader :git

      def git_object(path)
        Git.open(path)
      rescue ArgumentError
        fail Versionify::NotRepositoryError
      end
    end
  end
end

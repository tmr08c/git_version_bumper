require 'git'
require 'debugger'

module Versionify
  class CLI
    SUCCESS_EXIT_STATUS = 0
    ERROR_EXIT_STATUS = 1

    class NotRepositoryError < StandardError; end

    def initialize
    end

    def run
      git = git_object

      SUCCESS_EXIT_STATUS
    rescue NotRepositoryError
      $stderr.puts 'Error: Directory is not a repository'
      ERROR_EXIT_STATUS
    end

    private

    attr_reader :git

    def git_object
      Git.open(FileUtils.pwd)
    rescue ArgumentError
      fail NotRepositoryError
    end
  end
end

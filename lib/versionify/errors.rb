module Versionify
  # Base error class
  # Versionify-specific exceptions should inherit from this class
  class Error < StandardError; end

  module Errors
    # This error should be raised when attempting to use
    # Versionify with a directory that is not a Git repository
    class NotRepositoryError < Versionify::Error; end

    # This error should be raised when attempting to use Versionify
    # to bump a non-standard vesion type
    #
    # The currently allowed types are
    #
    # * MAJOR
    # * MINOR
    # * PATCH
    #
    # and are pulled from http://semver.org/
    class InvalidVersionBumpType < Versionify::Error; end
  end
end

module GitVersionBumper
  # Base error class
  # GitVersionBumper-specific exceptions should inherit from this class
  class Error < StandardError; end

  module Errors
    # This error should be raised when attempting to use
    # GitVersionBumper with a directory that is not a Git repository
    class NotRepositoryError < GitVersionBumper::Error; end

    # This error should be raised when attempting to use GitVersionBumper
    # to bump a non-standard vesion type
    #
    # The currently allowed types are
    #
    # * MAJOR
    # * MINOR
    # * PATCH
    #
    # and are pulled from http://semver.org/
    class InvalidVersionBumpType < GitVersionBumper::Error; end
  end
end

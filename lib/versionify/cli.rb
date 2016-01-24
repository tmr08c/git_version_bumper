require 'thor'
require 'debugger'

module Versionify
  class NotRepositoryError < StandardError; end

  class CLI < Thor
    SUCCESS_EXIT_STATUS = 0
    ERROR_EXIT_STATUS = 1
    # Version number naming shema based on Semantic Versioning
    # See http://semver.org/ for more details
    VALID_BUMP_TYPES = %w(MAJOR MINOR PATCH)

    class InvalidVersionBumpType < StandardError; end

    desc(
      'bump TYPE',
      'Bump the version of you application.' \
      'Where TYPE can be MAJOR, MINOR, or PATC'
    )
    def bump(version_type)
      bumper = bumper_for(version_type)
      bumper.bump
      # add logic to check for accepted versions here
      SUCCESS_EXIT_STATUS
    rescue NotRepositoryError
      $stderr.puts 'Error: Directory is not a repository'
      ERROR_EXIT_STATUS
    rescue InvalidVersionBumpType
      $stderr.puts 'Error: Invalid TYPE for version bump.' \
        " TYPE must be one of #{VALID_BUMP_TYPES.join(', ')}"
      ERROR_EXIT_STATUS
    end

    private

    def bumper_for(version_type)
      if VALID_BUMP_TYPES.include?(version_type.upcase)
        Versionify::VersionBumper::MajorVersionBumper.new(FileUtils.pwd)
      else
        raise InvalidVersionBumpType
      end
    end
  end
end

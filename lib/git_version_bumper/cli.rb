require 'thor'

module GitVersionBumper
  # Handles logic associated with command line interface.
  # Uses Thor to make interaction more pleasant.
  class CLI < Thor
    SUCCESS_EXIT_STATUS = 0
    ERROR_EXIT_STATUS = 1

    # Version number naming shema based on Semantic Versioning
    # See http://semver.org/ for more details
    MAJOR_VERSION_TYPE = 'MAJOR'.freeze
    MINOR_VERSION_TYPE = 'MINOR'.freeze
    PATCH_VERSION_TYPE = 'PATCH'.freeze
    VALID_BUMP_TYPES = [
      MAJOR_VERSION_TYPE,
      MINOR_VERSION_TYPE,
      PATCH_VERSION_TYPE
    ].freeze

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
    rescue Errors::NotRepositoryError
      $stderr.puts 'Error: Directory is not a repository'
      ERROR_EXIT_STATUS
    rescue Errors::InvalidVersionBumpType
      $stderr.puts 'Error: Invalid TYPE for version bump.' \
        " TYPE must be one of #{VALID_BUMP_TYPES.join(', ')}"
      ERROR_EXIT_STATUS
    end

    private

    def bumper_for(version_type)
      case version_type.upcase
      when MAJOR_VERSION_TYPE
        GitVersionBumper::VersionBumper::MajorVersionBumper.new(FileUtils.pwd)
      when MINOR_VERSION_TYPE
        GitVersionBumper::VersionBumper::MinorVersionBumper.new(FileUtils.pwd)
      when PATCH_VERSION_TYPE
        GitVersionBumper::VersionBumper::PatchVersionBumper.new(FileUtils.pwd)
      else
        fail Errors::InvalidVersionBumpType
      end
    end
  end
end

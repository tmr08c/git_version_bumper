require 'git_version_bumper/version_bumper/null_tag'

module GitVersionBumper
  module VersionBumper
    # Local represenation of Git::Object::Tag
    # Created to allow for custom sorting of git tags
    class Tag
      include Comparable

      attr_reader :major, :minor, :patch

      def initialize(major, minor, patch)
        @major = Integer(major)
        @minor = Integer(minor)
        @patch = Integer(patch)
      end

      def self.current(git_object)
        tags = git_object.tags
        return NullTag.new if tags.empty?

        tags
          .map { |tag| Tag.from_name(tag.name) }
          .sort
          .last
      end

      def self.from_name(tag_name)
        tag_name = tag_name.sub('v', '')
        major, minor, patch = tag_name.split('.')

        Tag.new(major, minor, patch)
      end

      def name
        "v#{major}.#{minor}.#{patch}"
      end

      def <=>(other)
        if major == other.major
          if minor == other.minor
            patch <=> other.patch
          else
            minor <=> other.minor
          end
        else
          major <=> other.major
        end
      end
    end
  end
end

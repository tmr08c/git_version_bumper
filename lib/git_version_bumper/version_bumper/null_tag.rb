module GitVersionBumper
  module VersionBumper
    # Null Object represenation of Git::Object::Tag
    class NullTag
      def initialize; end

      def name
        'v0.0.0'.freeze
      end
    end
  end
end

module GitVersionBumper
  module VersionBumper
    class NullTag
      def initialize; end

      def name
        'v0.0.0'.freeze
      end
    end
  end
end

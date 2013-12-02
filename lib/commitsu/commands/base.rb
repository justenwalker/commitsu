module Commitsu
  module Commands
    class Base
      attr_reader :environment, :options
      def initialize(options)
        @environment = Environment.new(options)
        @options     = options
        @environment.setup!
      end
    end
  end
end


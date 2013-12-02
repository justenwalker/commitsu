module Commitsu
  module Interface
    class TextSummary
      attr_reader :text
      def initialize(options)
        options.each_pair do |k,v|
          raise 'Cannot set @value during initialization' if k == :value
          instance_variable_set("@#{k}".to_sym,v)
        end
      end
      def value
        @value = real_value unless @value
        @value
      end
      def bind(&block)
        @bind = block
      end
      def ask!
        @bind.call(value)
      end
      private
      def real_value
        HighLine.ask(@text) do |q|
          q.validate = @validate if @validate
          q.limit = @length
        end
      end
    end
  end
end

module Commitsu
  module Interface
    class TextChoice
      attr_reader :text,:choices
      def initialize(options)
        options.each_pair do |k,v|
          raise 'Cannot set @value during initialization' if k == :value
          instance_variable_set("@#{k}".to_sym,v)
        end
      end
      def value
        real_value unless @value
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
        HighLine.choose do |menu|
          menu.prompt = @text
          @choices.each do |choice|
            menu.choice(choice[:name]) { @value = choice[:value] }
          end
        end
      end
    end
  end
end

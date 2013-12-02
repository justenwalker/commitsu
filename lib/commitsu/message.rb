require 'word_wrapper'
module Commitsu
  class TemplateNotDefinedError < StandardError

  end
  class Message
    extend Commitsu::DSL

    attr_reader :interface

    def initialize(environment)
      @environment = environment
      @interface = environment.new_interface(self)
    end

    dsl do
      def template(name)
        _set_template(name)
      end
      def issues
        get_issues
      end
      def interface(&block)
        _interface.instance_eval(&block)
      end
    end


    def word_wrap(text,cols=72)
      WordWrapper::MinimumRaggedness.new(cols, text).wrap
    end

    def set_attr(name,val)
      instance_variable_set("@#{name}".to_sym,val)
    end

    def render(filename)
      if @template.nil?
        raise TemplateNotDefinedError,'Template was not defined'
      end
      @interface.run!
      File.open(filename,'w') do |file|
        file.write(@template.render(self))
      end
    end

    def get_binding
      binding
    end

    def get_issues
      @environment.tracker.issues.sort { |a,b| a.name <=> b.name }
    end

    def _set_template(name)
      @template = @environment.new_template(name)
    end

    def _interface
      @interface
    end




  end
end
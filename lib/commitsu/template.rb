require 'erb'
module Commitsu
  class Template
    def initialize(file)
      @erb = ERB.new(File.read(file),0,'-')
    end
    def render(message)
      @erb.result(message.get_binding)
    end
  end
end
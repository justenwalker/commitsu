require 'highline/import'
require 'commitsu/interface/text/summary'
require 'commitsu/interface/text/choice'
module Commitsu
  module Interface
    class Text
      attr_reader :message
      def initialize(message)
        @message = message
        @parameters = []
      end
      def summary(parameter,options={})
        o = {
            :text   => "#{parameter}: ",
            :length => 50,
        }.merge(options)
        s = TextSummary.new(o)
        s.bind do |value|
          @message.set_attr(parameter,value)
        end
        @parameters << s
      end
      def choice(parameter,options={})
        o = {
            :text   => "Choose #{parameter}: ",
            :choices => [],
        }.merge(options)
        s = TextChoice.new(o)
        s.bind do |value|
          @message.set_attr(parameter,value)
        end
        @parameters << s
      end
      def run!
        @parameters.each do |p|
          p.ask!
        end
      end
    end
  end
end


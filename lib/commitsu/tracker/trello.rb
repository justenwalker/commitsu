require 'trello'
require 'commitsu/issue'

module Commitsu
  module Tracker
    class Trello
      def initialize(environment)
        @environment = environment
        @username = @environment.config['trello']['user']
        @api_key = @environment.config['trello']['api_key']
        @api_token = @environment.config['trello']['user_token']
      end
      def issues
        ::Trello.configure do |config|
          config.developer_public_key = @api_key
          config.member_token = @api_token
        end
        begin
        member = ::Trello::Member.find(@username)
        rescue
          []
        end
        raise "User #{@username} not found in Trello" unless member
        member.cards.map do |c|
          Commitsu::Issue.new({
              :id      => c.id,
              :name    => c.name,
              :summary => c.desc,
              :url     => c.url
          })
        end
      end
    end
  end
end

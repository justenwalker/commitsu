require 'thor'

require 'commitsu'
require 'commitsu/commands'
require 'commitsu/environment'
module Commitsu
  class Cli < Thor
    package_name 'Commitsu'
    class_option :home, :type => :string, :desc => <<-eos.strip
      Commitsu home directory. (Default: #{Commitsu::Environment.default_home})
    eos
    class_option :issuetracker, :type => :string, :desc => <<-eos.strip
      Issue tracker name (Configured in config.yaml).
    eos
  
    desc 'prompt FILE [MESSAGE_TYPE]', <<-eos.strip
      Prompts for a commit message and prints the result to the FILE
    eos
    def prompt(file,message='git')
      p = Commitsu::Commands::Prompt.new(options)
      p.run(file,message)
    end

    desc 'generate_home', <<-eos.strip
      Generates the commitsu home directory with a skeleton configuration.
    eos
    def generate_home
      Commitsu::Commands::GenerateHome.new(options).run()
    end
    
    desc 'version', 'Shows the current version of commitsu'
    def version
      say "commitsu v#{Commitsu::VERSION}"
    end
  end
end


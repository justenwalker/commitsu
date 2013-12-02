require 'yaml'
require 'commitsu/interface'
require 'commitsu/trackers'

module Commitsu
  class Environment
    class ResourceNotFoundError < StandardError; end

    attr_reader :home,:config,:tracker

    def self.default_home
      Pathname.new(File.expand_path('~').to_s).join('.commitsu')
    end

    def self.default_config
      {

      }
    end

    # Creates a new environment
    # @param [Hash] options command-line options
    def initialize(options)
      @options = options
    end

    # Sets up the commitsu environment
    def setup!
      if @options.has_key?(:home)
        @home = Pathname.new(@options[:home])
      elsif not ENV['COMMITSU_HOME'].nil?
        @home = Pathname.new(ENV['COMMITSU_HOME'])
      else
        @home = Environment.default_home
      end
      load_config!
      @gui = @options.has_key?('gui')
      if @options.has_key?('issuetracker')
        begin
        @tracker = Commitsu::Trackers.get(@options['issuetracker'],self)
        rescue LoadError => le
          puts "Unable to load tracker. Gem not found: #{le}"
          @tracker = Commitsu::Trackers.none
        end
      else
        @tracker = Commitsu::Trackers.none
      end
    end

    # Finds a resource in the environment
    #
    # The priority of the search is as follows:
    # 1. If the path is absolute, it uses that directly
    # 2. If the path is relative then:
    #    1. relative to COMMITSU_HOME
    #    2. relative to the gem's 'resources' directory
    #
    # @param [String] path Absolute path to file, or relative path from home directory
    # @return [File] file object of the found resource
    # @raise [ResourceNotFoundError] if the file was not found
    def find_resource(path)
      p = Pathname.new(path)
      if p.absolute?
        raise ResourceNotFoundError, "Unable to find resource #{path}" unless p.readable?
      else
        home_res = @home.join(path)
        gem_res  = Pathname.new(Commitsu::ROOT_DIR).join('resources').join(path)
        locations = [ home_res, gem_res ]
        p = locations.find { |p| p.readable? }
        raise ResourceNotFoundError, "Unable to find resource #{path} in #{locations}" unless p
      end
      File.new(p.to_s)
    end

    # Creates a new [Message] object of the given type
    #
    # Types are defined as DSLs in COMMITSU_HOME/messages
    #
    # @param [String] type The type of message
    # @return [Message] a new message
    # @raise [ResourceNotFoundError] if the type file is not found
    def new_message(type)
      file = find_resource(Pathname('messages').join(type).to_s)
      Message.from_file(file,self)
    end

    # Creates a new [Template] object of the given name
    #
    # Templates are defined as ERBs in COMMITSU_HOME/templates
    #
    # @param [String] name Name of the template
    # @return [Template] a new template
    # @raise [ResourceNotFoundError] if the template file was not found
    def new_template(name)
      file = find_resource(Pathname('templates').join(name).to_s)
      Template.new(file)
    end

    # Creates a new [Interface] object
    #
    # The implementation type depends on the environment
    # @param [Message] message target message
    # @return [Interface] new interface
    def new_interface(message)
      if @gui
        Commitsu::Interface::Gui.new(message)
      else
        Commitsu::Interface::Text.new(message)
      end
    end

    private
    # Loads the config.yaml
    #
    def load_config!
      begin
        cfg = find_resource(Pathname.new('config.yaml'))
        cfg_hash = YAML.load_file(cfg)
        @config = Environment.default_config.merge(cfg_hash)
      rescue
        @config = Environment.default_config
      end
    end
  end
end
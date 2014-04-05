require 'pathname'

module Multidb
  class Configuration
    attr_reader :default_pool
    attr_reader :default_adapter
    attr_reader :raw_configuration

    def initialize(default_adapter)
      #      @default_pool = ActiveRecord::Base.connection_pool
      yaml = Pathname.new("config/database.yml")
      @default_adapter = default_adapter

      @raw_configuration = if yaml.exist?
                 require "yaml"
                 require "erb"
                 YAML.load(ERB.new(yaml.read).result) || {}
               elsif ENV['DATABASE_URL']
                 # Value from ENV['DATABASE_URL'] is set to default database connection
                 # by Active Record.
                 {}
               else
                 raise "Could not load database configuration. No such file - #{yaml}"
               end
    end 
  end
end

require 'multidb'

@config = Multidb::Configuration.new('config/database.yml')
p @config.raw_configuration
p @config.raw_configuration["development"]

#module Multidb
#  class ConfigurationTest
#  end
#end

module Multidb
  class Configuration
    def initialize(default_adapter, configuration_hash)
      @default_pool = ActiveRecord::Base.connection_pool
      @default_adapter = default_adapter
      @raw_configuration = configuration_hash
    end

    attr_reader :default_pool
    attr_reader :default_adapter
    attr_reader :raw_configuration
  end
end

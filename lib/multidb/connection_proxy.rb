require 'active_record/connection_adapters/abstract/query_cache'

module Multidb
  class ConnectionProxy
    include ActiveRecord::ConnectionAdapters::QueryCache
    include QueryCacheCompat
    extend ThreadLocalAccessors

    attr_accessor :master
    
    class << self
      attr_accessor :environment
      attr_accessor :master_models
      attr_accessor :sticky_slave

      def setup
        p "multidb setup method."
        @environment ||= (defined?(Rails) ? Rails.env : 'development')
        @sticky_slave ||= false
        @master =  ActiveRecord::Base
        slave  = init_slaves
      end

      protected
      def init_slaves

      end
    end

  end
end

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
      attr_accessor :defaults_to_master

      def setup
        p "multidb setup method."
        @environment ||= (defined?(Rails) ? Rails.env : 'development')
        @sticky_slave ||= false
        master =  ActiveRecord::Base
        slaves  = init_slaves
        raise "No slaves databases defined for environment: #{self.environment}" if slaves.empty?
        master.send :include, MultiDb::ActiveRecordExtensions
        raise "No slaves databases defined for environment: #{self.environment}" if slaves.empty?
        master.send :include, MultiDb::ActiveRecordExtensions
      end

      protected
      def init_slaves
        [].tap do |slaves|
          ActiveRecord::Base.configurations.each do |name, values|
            if name.to_s =~ /#{self.environment}_(slave_database.*)/
              weight  = if values['weight'].blank?
                          1
                        else
                          (v=values['weight'].to_i.abs).zero?? 1 : v
                        end
            end
          end
        end
      end

      def send_to_master(method, *args, &block)
        reconnect_master! if @reconnect
        @master.retrieve_connection.send(method, *args, &block)
      rescue => e
        raise_master_error(e)
      end

      def send_to_current(method, *args, &block)
        reconnect_master! if @reconnect && master?
        current.retrieve_connection.send(method, *args, &block)
      rescue NotImplementedError, NoMethodError
        raise
      rescue => e # TODO don't rescue everything
        raise_master_error(e) if master?
        logger.warn "[MULTIDB] Error reading from slave database"
        logger.error %(#{e.message}\n#{e.backtrace.join("\n")})
        @slaves.blacklist!(current)
        next_reader!
        retry
      end
    end
  end
end

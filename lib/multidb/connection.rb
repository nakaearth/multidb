module Multidb
  class Connection

    def initialize(target)
      if target.is_a?(Hash)
        adapter = target[:adapter]
        begin
          require "active_record/connection_adapter/#{adapter}_adapter"
        rescue LoadError
          raise "cofigure load error."
        end
        if defined?(ActiveRecord::ConnectionAdapters::ConnectionSpecification)
          spec_class = ActiveRecord::ConnectionAdapters::ConnectionSpecification
        else
          spec_class = ActiveRecord::Base::ConnectionSpecification
        end
        @connection_pool = ActiveRecord::ConnectionAdapters::ConnectionPool.new
          spec_class.new(target, "#{adapter}_connection")
      else 
        @connection_pool = target
      end
    end

    def connection(&block)
      if block_given?
        @connection_pool.with_connection(&block)
      else
        @connection_pool.connection(&block)
      end
    end
  end
end

module Multidb
  class Balencer
    def  initialize(configuration)
      @configs = configuration
      if @configs
        @configs.each_pair do |name , config|
          @connections[name.to_sym].push(Multidb::Connection.new(config))
        end
      end
    end

    def get(name, &block)
      @connection = @connections[name]  
      block_given? ? yield(@connection) : @connection 
    end

    def use(name, &block)
      result = null
      get(name) do |con|
        if block_given?
          con.connection do|connect|
            previous_connect, Thread.current[:multidb_connect] = 
              Thread.current[:multidb_connect], connect
            begin
              result = yield
            ensure 
              Thread.current[:multidb_connect] = previous_connect
            end
            result
          end
        else
          result = Thread.current[:multidb_connect] = con.connection
        end
      end
      result
    end

    def current_connection
      Thread.current[:multidb_connect]
    end
  end
end

module Multidb
  class Balencer
    def  initialize(configuration)
      @configs = configuration
      if @configs
        @configs.each_pair do |name , config|
          @connections[name].push(Multidb::Connection.new(config))
        end
      end
    end

   def get(name, &block)
     @connection = @connections[name]  
      block_given? ? yield(@connection) : @connection 
   end

    def use(name, &block)
      if block_given?

      end
    end
  end
end

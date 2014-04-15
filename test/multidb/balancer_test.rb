require 'multidb'


class User < ActiveRecord::Base

end

@config   = Multidb::Configuration.new('sqlite3')
p @config
@balencer = Multidb::Balencer.new(@config.raw_configuration)
@balencer.use(:development) do
  User.all
end

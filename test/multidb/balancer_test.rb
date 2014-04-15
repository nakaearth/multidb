require 'multidb'


class User < ActiveRecord::Base

end

@config   = Multidb::Configuration.new('sqlite3')
@balencer = Multidb::Balencer.new(@config)
@balencer.use(:development) do
  User.all
end

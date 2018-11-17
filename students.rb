#set up sqlite
#require 'data_mapper'
require "dm-core"
require "dm-migrations"

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/student.db") if development?
DataMapper.setup(:default,"postgres://root:secretpass@127.0.0.1/student") if production?
# define class to represent student table
class Students
  include DataMapper::Resource # mixin
  property :id, Serial
  property :studentID, Text
  property :firstname, String
  property :lastname, String
  property :birthday, Date
  property :address, Text
end

# handle sqlite
DataMapper.finalize
DataMapper.auto_migrate!
DataMapper.auto_upgrade!

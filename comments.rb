#set up sqlite

require "dm-core"
require "dm-migrations"
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/comments.db") if development?
DataMapper.setup(:default,"postgres://root:secretpass@127.0.0.1/comments") if production?

# comments table
class Comments
  include DataMapper::Resource # mixin
  property :id, Serial
  property :name, String
  property :title, String
  property :content, Text
  property :created_at, DateTime
end
# handle sqlite queries

DataMapper.finalize
DataMapper.auto_upgrade!

require 'data_mapper'

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, Text, :required => true
  property :created, DateTime
end
#!/usr/bin/ruby
require 'rubygems'
require "sinatra"
require 'data_mapper'
require "json"
require "pp"
require 'rgeo/geo_json'

#require 'leaflet'
#var handler = require('leaflet-path-drag')


DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/users.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, Text, :required => true
  property :created, DateTime
end

class Geo
	include DataMapper::Resource
	property :id, Serial
	property :name, Text
	property :latitude, Text
	property :longitude, Text
end

DataMapper.finalize.auto_upgrade!

#Simple App
get "/" do
	"Welcome to first sinatra application"
end

#Add User Form
get "/add_user" do
	erb :index
end

#New User Entry in Table
post "/new_user" do
	user = User.create( :username => params[:usertxt], :created=>Time.now)
	redirect "/users"
end

#User Lists
get "/users" do
	@users = User.all(:order=> :created.desc)
	erb :users
	
end

get "/delete/:id" do
	userid = User.first(params[:id])
	userid.destroy
	redirect "users"
end


get "/geo" do
	
	geoCord = '{
				"type":"Polygon",
				"coordinates":[[ [70,0],[70,10],[75,10],[75,0] ]]
				}'
	erb :geo, :locals =>{ :geoC => geoCord}
end










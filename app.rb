#!/usr/bin/ruby


require 'sinatra'
require 'sinatra/reloader'
require_relative 'students'
require_relative 'comments'
require_relative 'routes'

DataMapper.setup(:default, ENV['DATABASE_URL']) if production?

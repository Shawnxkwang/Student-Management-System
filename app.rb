#!/usr/bin/ruby


require 'sinatra'
require 'sinatra/reloader'
require "dm-core"
require "dm-migrations"
require_relative 'students'
require_relative 'comments'
require_relative 'routes'

DataMapper.setup(:default, ENV['DATABASE_URL']) if production?

#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'

heartbeats = []

get '/' do
  return "no heartbeats yet" if heartbeats.length <= 0

  @list = heartbeats.sort_by{ |b| b[:updated_at]}.reverse!

  erb :index
end

post '/' do
  json = JSON.parse(request.body.read)

  heartbeat = {
    :WorldName => json["server"],
    :OnlineCount => json["online"],
    :updated_at => Time.now.utc.iso8601
  }

  heartbeats.push(heartbeat);

  status 200
  return ""
end

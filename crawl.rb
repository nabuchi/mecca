#!/usr/bin/env ruby
#-*- encoding: utf-8 -*-
require 'mongo'

m = Mongo::Connection.new('localhost',27017)

m.database_names.each{|name| puts name}

db = m.db('mecca')

#db['products'].insert({
#    :name => '耳をすませば',
#    :place => ['聖蹟桜ヶ丘駅','東京都'],
#    :image => 'mimi.jpg'
#})

puts db['users'].count

db['products'].find({:name => /^耳/}).each do |i|
    puts i
end

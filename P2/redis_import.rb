#!/usr/bin/ruby

require "redis"
require "rubygems"
require "json"

redis = Redis.new
# Datenbank vorher loeschen
redis.flushdb
puts "drop database"

puts "run import"

beginning_time = Time.now
f = File.open("/media/sf_haw.bai5.nosql_wpp/P2/plz.data", "r")

hash = {}
f.each_line do |line|
	jsonData = JSON.parse(line)
	id = jsonData["_id"]
	redis.hmset(id, "city", jsonData["city"], "loc", jsonData["loc"].to_s, "pop", jsonData["pop"], "state", jsonData["state"])

  redis.sadd(jsonData["city"], id)
end
f.close
end_time = Time.now
puts "import completed"
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"

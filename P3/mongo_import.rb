require 'rubygems'  # not necessary for Ruby 1.9
require 'mongo'
require 'json'

include Mongo
# keine Debug Ausgabe auf der Konsole
Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'local')
# Collection vorher loeschen
client[:postals].drop
puts "drop collection"

puts "run import"

beginning_time = Time.now
f = File.open("/media/sf_wpp_nosql/P2/plz.data", "r")

f.each_line do |line|
  client[:postals].insert_one(JSON.parse(line))
end
f.close
end_time = Time.now
puts "import completed"
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"

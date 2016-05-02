require 'rubygems'  # not necessary for Ruby 1.9
require 'mongo'
require 'json'

include Mongo
# keine Debug Ausgabe auf der Konsole
Mongo::Logger.logger.level = ::Logger::FATAL

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'local')
# Collection vorher loeschen
client[:sinndeslebens].drop
puts "drop collection"

puts "run import"

beginning_time = Time.now
f = File.open("/media/sf_haw.bai5.nosql_wpp/P3/sinndeslebens_edit.txt", "r")

f.each_line do |line|
  #line.sub!("db.fussball.insert(", "") # remove "db.fussball.insert("
  #line = line[0..-4] # remove  ");"
  #puts line
  client[:sinndeslebens].insert_one(JSON.parse(line))
end
f.close
end_time = Time.now
puts "import completed"
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"

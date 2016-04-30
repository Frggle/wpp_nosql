##!/usr/bin/env ruby
#!/usr/bin/ruby

require 'mongo'
require 'json'

# kleines Shell Tool um interaktiv mit den PLZ der mongoDB zu agieren
# Datum: 2016-04-29

# keine Debug Ausgabe auf der Konsole
Mongo::Logger.logger.level = ::Logger::FATAL
$client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'local')

def help
  puts '>> exit zum Beenden'
  puts '>> plz => wenn der Ort und Staat zu einer PLZ gesucht ist'
  puts '>> city => wenn die Postleitzahl zu einem Ort gesucht ist'
end

def getCityAndState
  input = gets.chomp
  documents = $client[:postals].find('_id' => input)
  if !documents.nil?
    documents.each do |document|
      puts 'City: ' + document['city']
      puts 'State: ' + document['state']
    end
  else
    puts 'invalid input'
  end
end

def getPLZ
  beginning_time = Time.now
  input = gets.chomp
  documents = $client[:postals].find('city' => input.upcase)
  if !documents.nil?
    documents.each do |document|
      puts 'Plz ' + document['_id']
    end
  else
    puts 'invalid input'
  end
  end_time = Time.now
  puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
end

$aktiv = true

while($aktiv) do
  puts '>> help fuer Hilfe'

  command = gets.chomp
  case command
    when 'help'
      help
    when 'plz'
      puts '>> bitte PLZ eingeben:'
      getCityAndState
    when 'city'
      puts '>> bitte City eingebben:'
      getPLZ
    when 'exit'
      $aktiv = false
    else
      puts '>> invalid command'
  end
end

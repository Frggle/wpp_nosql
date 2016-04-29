##!/usr/bin/env ruby
#!/usr/bin/ruby

require 'redis'

# kleines Shell Tool um interaktiv mit den PLZ der redis DB zu agieren
# Datum: 2016-04-03

$redis = Redis.new

def help
  puts '>> exit zum Beenden'
  puts '>> plz => wenn der Ort und Staat zu einer PLZ gesucht ist'
  puts '>> city => wenn die Postleitzahl zu einem Ort gesucht ist'
end

def getCityAndState
  input = gets.chomp
  city = $redis.hget(input, 'city')
  if !city.nil?
    puts 'City: ' + city
    puts 'State: ' + $redis.hget(input, 'state')
  else
    puts 'invalid input'
  end
end

def getPLZ
  input = gets.chomp
  #plz = $redis.get(input.upcase)
  plz = $redis.smembers(input.upcase)
  if !plz.nil?
    puts 'PLZ: ' + plz.join(",")
  else
    puts 'invalid input'
  end
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

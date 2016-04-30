##!/usr/bin/env ruby
#!/usr/bin/ruby

require 'mongo'
require 'json'

# kleines Shell Tool um interaktiv mit den Teilaufgabe von sinndeslebens der mongoDB zu agieren
# Datum: 2016-04-29

# keine Debug Ausgabe auf der Konsole
Mongo::Logger.logger.level = ::Logger::FATAL
$client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'local')

# Schreibt eine Collection elementweise auf die Konsole
def out(doc)
  doc.each do |elem|
    puts elem
  end
end

def help
  puts '>> exit zum Beenden'
  puts '>> Buchstabe b, c, d und e fuer die jeweilige Teilaufgabe'
end

def getB
  doc1 = $client[:sinndeslebens].find('name' => 'Augsburg')
  puts '1) mit Namen Augsburg:'
  out(doc1)
  puts '------'
  puts '2) alle Nike-Vereine, welche schwarz als mindestens eine Vereinsfarbe haben'
  doc2 = $client[:sinndeslebens].find('nike' => 'j', 'farben' =>  { '$in' => ['schwarz'] })
  out(doc2)
  puts '------'
  puts '3) alle Nike-Vereine, welche weiss und grün als Vereinsfarbe haben'
  doc3 = $client[:sinndeslebens].find('nike' => 'j', 'farben' =>  { '$in' => ['weiss'] }, 'farben' => { '$in' => ['gruen'] })
  out(doc3)
  puts '------'
  puts '4) alle Nike-Vereine, welche weiss oder grün als Vereinsfarbe haben'
  doc4 = $client[:sinndeslebens].find('nike' => 'j', 'farben' =>  { '$in' => ['weiss', 'gruen'] })
  out(doc4)
  puts '------'
  puts '5) den Verein mit dem höchsten Tabellenplatz'
  doc5 = $client[:sinndeslebens].find({}, '$sort' => ['Tabellenplatz', 'desc'])
  puts doc5.first
  puts '------'
  puts '6) alle Vereine, die nicht auf einem Abstiegsplatz (17 und 18) stehen'
  doc6 = $client[:sinndeslebens].find({ 'Tabellenplatz': { '$lt' => '17' }} )
  out(doc6)
end

def getC
  puts 'Aggregatsfunktion mit projection'
  doc = $client[:sinndeslebens].find('name' => 'Augsburg').projection({ 'name': 1, '_id': 0 })
  out(doc)
end

def getD
  puts 'db.fussball.update({name: \'Augsburg\'}, {Tabellenplatz: 1})'
  doc = $client[:sinndeslebens].update_one({ 'name' => 'Augsburg' }, { 'Tabellenplatz' => '1' })
  out(doc)
end

def getE
  puts '1) Ändern sie den Tabellenplatz von Leverkusen auf 2'
  doc1 = $client[:sinndeslebens].find_one_and_update({ 'name' => 'Leverkusen' }, { '$set' => { 'Tabellenplatz' => 2 }}, :return_document => :after)
  puts doc1
  puts '------'
  puts '2) Werder soll um einen Tabellenplatz nach vorne gebracht werden'
  doc2 = $client[:sinndeslebens].find_one_and_update({ 'name' => 'Werder' }, { '$inc' => { 'Tabellenplatz' => 1 }}, :return_document => :after)
  puts doc2
  puts '------'
  puts '3) Ergänzen sie für den HSV ein Attribut „abgestiegen“ mit einem sinnvollen Wert'
  doc3 = $client[:sinndeslebens].find_one_and_update({ 'name' => 'HSV' }, { '$set' => { 'abgestiegen' => 'y'}}, :return_document => :after)
  puts doc3
  puts '------'
  puts '4) Ergänzen sie für alle Vereine, deren Vereinsfarbe weiss enthält, ein Attribut „Waschtemperatur“ mit dem Wert 90.'
  doc4 = $client[:sinndeslebens].find('farben' =>  { '$in' => ['weiss'] }).update_many({ '$set' => { 'Waschtemperatur' => 90}}, :return_document => :after)
  out(doc4)
end

$aktiv = true
while($aktiv) do
  puts '>> help fuer Hilfe'
  command = gets.chomp
  case command
    when 'help'
      help
    when 'b'
      getB
    when 'c'
      getC
    when 'd'
      getD
    when 'e'
      getE
    when 'exit'
      $aktiv = false
    else
      puts '>> invalid command'
  end
end

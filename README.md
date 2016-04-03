# WPP NoSQL und BigData

Es wird benötigt:
- redis 
- ruby
- gem json (gem install json)
- gem redis-rb (gem install redis)
- rubygems (sudo apt-get install rubygems-integration)

## Aufgabe 4
Die Datenstruktur ist ein HSET (Hash). Die PLZ ist der Hash mit den verschiedenen Feldern wie pop oder state.
Zusätzlich ist die city als Key mit der id (PLZ) als Value hinterlegt.
Update: die Datenstruktur ist jetzt ein HMSET

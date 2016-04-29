# WPP NoSQL und BigData

## Praktikum 1

Die Aufgabe des ersten Termins bestand lediglich darin die Infrastruktur zu schaffen (VirtualBox mit Ubuntu und noSQL DB aufsetzen)

## Praktikum 2

Es wird benötigt:
- redis 
- ruby
- gem json (gem install json)
- gem redis-rb (gem install redis)
- rubygems (sudo apt-get install rubygems-integration)

#### Aufgabe 4
Die Datenstruktur ist ein HSET (Hash). Die PLZ ist der Hash mit den verschiedenen Feldern wie pop oder state.
Zusätzlich ist die city als Key mit der id (PLZ) als Value hinterlegt. 
<br>
ggf. muss der Pfad zur plz.data angepasst werden
<br>
Update: die Datenstruktur ist jetzt ein HMSET <br>

## Praktikum 3

#### Aufgabe 7
redis
- LoC - interaktive Konsole: 45
- LoC - import Script: 16
- Aufwand: mittel
- import time:
- get plz für Hamburg:

mongo
- LoC - interaktive Konsole: 51
- LoC - import Script: 14
- Aufwand: leicht 
- import time:
- find plz für Hamburg:



--Backup

/* 
Fälle

Server defekt
DB defekt
Logischer Fehler .. falsches Update
Wenn ich weiss, dass gleich was passieren kann
Teil einer DB defekt (zb logfile oder Datendatei). dh eine Datei ist noch funktionsfähig
Daten korrupt, aber schon 4 Wochen her...


Backuptypen

Vollsicherung  V
Differenzsicherug  D
Transaktionsprotkollsicherung T


! V
	T
	T
	T
D
	T
	T
	T
! D
!	T
!	T
!	T  11:30 


V
sichert einen Zeitpunkt
sichert auch die Dateien inkl Pfad und Größe
Checkpoint


D
sichert einen Zeitpukt
sichert geänderte Datenseiten seit V weg
Checkpoint
verkürzt und sicht perfekt den Restore

T
checkpoint
sichert eine Verlauf


Welche Sicherung ist der schnellste Restore?
V
so häufig wie möglich


Wie lange dauert der Restore eines T?
dauert solange wie die Anweisung dauerten
was solte man alsi nicht tun?
VTTTTXTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT


Wovon hängt mein Backup an?
--Datenverlust in Zeit  T Intervall
--Ausfallzeit der DB
--was wenn V restore > Ausfallzeit---> Hochverfügbarkeit



RecoveryModel

Einfach
alle TX (I U D) werden protokolliert und löscht die TX später wieder aus dem Log
kein restore via Tlog--> leert sich automatisch
auch Bulk wird auch protokolliert aber nur geringfügi prokolliert



Massenprokolliert
alle TX (I U D) auch Bulk, aber wieder geringfügig
es wird allerdings nichts gelöscht
Pflicht! Logfile muss gesihert werden--> leert das Log
Restore könnte theoretisch auf Sekunde klappen, wen kein BULK vorkam


Vollständige
protkolliert umfangreich jede Aktion (auch IX)
auch Bulk, aber sehr exakt
jetzt Restore auf Sekunde möglich

--man kann jederezeit das Model umstellen

--von Vollst --> Einfach




























*/
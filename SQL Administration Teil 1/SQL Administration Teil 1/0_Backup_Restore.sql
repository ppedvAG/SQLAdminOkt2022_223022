--Backup

/* 
F�lle

Server defekt
DB defekt
Logischer Fehler .. falsches Update
Wenn ich weiss, dass gleich was passieren kann
Teil einer DB defekt (zb logfile oder Datendatei). dh eine Datei ist noch funktionsf�hig
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
sichert auch die Dateien inkl Pfad und Gr��e
Checkpoint


D
sichert einen Zeitpukt
sichert ge�nderte Datenseiten seit V weg
Checkpoint
verk�rzt und sicht perfekt den Restore

T
checkpoint
sichert eine Verlauf


Welche Sicherung ist der schnellste Restore?
V
so h�ufig wie m�glich


Wie lange dauert der Restore eines T?
dauert solange wie die Anweisung dauerten
was solte man alsi nicht tun?
VTTTTXTTTTTTTTTTTTTTTTTTTTTTTTTTTDTTTT


Wovon h�ngt mein Backup an?
--Datenverlust in Zeit  T Intervall
--Ausfallzeit der DB
--was wenn V restore > Ausfallzeit---> Hochverf�gbarkeit



RecoveryModel

Einfach
alle TX (I U D) werden protokolliert und l�scht die TX sp�ter wieder aus dem Log
kein restore via Tlog--> leert sich automatisch
auch Bulk wird auch protokolliert aber nur geringf�gi prokolliert



Massenprokolliert
alle TX (I U D) auch Bulk, aber wieder geringf�gig
es wird allerdings nichts gel�scht
Pflicht! Logfile muss gesihert werden--> leert das Log
Restore k�nnte theoretisch auf Sekunde klappen, wen kein BULK vorkam


Vollst�ndige
protkolliert umfangreich jede Aktion (auch IX)
auch Bulk, aber sehr exakt
jetzt Restore auf Sekunde m�glich

--man kann jederezeit das Model umstellen

--von Vollst --> Einfach




























*/
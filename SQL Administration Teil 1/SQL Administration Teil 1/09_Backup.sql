/*
F�lle

1) Userfehler: Daten versehentlich ver�ndert oder gel�scht --> war falsch


2)  Patch/Update/SPs... mach vorher eine Sicherung


3) HDD defekt... entweder beide (LOG/DATEN)  oder nur eine HDD 


4) DB ist defekt


5) Server tot, aber HDDs leben..alle DB Dateien sind noch voll funktionsf�hig




Firmenregel:
Aufalldauer einer DB (Raktionszeit)--> Hochverf�gbarkeit
Max Datenverlust in Zeit... am besten mit geringst m�glichen Datenverlust



Sicherungsarten

Vollsicherung   V
differentiell   D
Transaktionsprotokollsicherung T


V   6:00       !
	T
	T
	Tdefekt
x 
	T
	T
	T
x        !
	 T            !  Tlog alle 30min
	 T            !
	 T  15:00 !




	 Vollsicherung: 
	 sichert Pfade , Dateiname, Gr��e, und Inhalte
	 zu einem Zeitpunkt


	 Diff
	 sichert alle Seiten und Bl�cke seit des letzten V
	 zu einem Zeitpunkt

	 TLog
	 sichert alle Anweisungen weg
	 restore spielt die Anweisungen wieder zur�ck

	 schnellster Restore:  das V, wenn es also schnell sein soll, dann sollte man das V so h�ufig wie m�glich 

	 wie lange dauert der Restore des 2 letzten Ts
	 solange wie die TX im Orig auch dauerten.. in unserem Fall bis zu 30min 
	 daher: Logfiles sollten keinen gro�en zeitlichen Umfang haben und alle paar TSicherung ein D einstreuen
	 und das D macht auch den Restire sicherer


	 ---Ausschlaggebened: RecoveryModel

	 Einfach
	 INS UP DEL , Bulk (rudiment�r)--> ist einen TX fertig, dann wird sie autom aus dem Tlog gel�scht
	 ==> keine Sicherung des Logfiles
	 --Einsatzgebiet: schneller, weil weniger schreiben, aber kein Restore �er Tlog , wartungsfrei--> TestDb, Datenverlust kann theor. sehr hoch sein (4h)

	 Massenprotokoliert
	 INS UP DE BULK (rudiment�r), aber es wird nichts gel�scht.Nur die Sicherung des Tlog entfernt Eintrage aus dem Tlog
	 Logfile muss regelm. gesichert werden, damit es auch wieder gleert wird
	 Restore per Logfile m�glich und evtl auch auf Sekunde genau, aber nur dann , wenn nur wenn kein Bulk

	 
	 Voll
	 INS UP DEL Bulk vollst�ndig (auch IX) ... auf Sekunde restore machbar
	 Logfile w�chst schneller und ist auch evtl langsamer beim Schreiben


	 --Was passiert mit dem Logfile, wenn man das Model von Full auf Einfach wechselt?
	 es wird geleert.. und per Logfile kein Restore mehr

	*/
	--Vollsicherung
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH NOFORMAT, NOINIT,  
	 NAME = N'Nwind Full', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Diff
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'Nwind Diff', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--Tlog
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' WITH NOFORMAT, NOINIT,  
NAME = N'Nwind Log', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--- V TTT D TTT D TTT       D   TTT    2022-09-06T11:04:31.3721112+02:00



--Fall1 : falsche Daten Userfehler
\\hv-sql2\c$    --> _backup
---T 11 Uhr-- 11:30 n�chste Sicherung
-- 11:17 --> 11:10!!

--wir wissen, was er ausfgefressen hat

--Idee: workaround: Tabelle restoren

--1. Restore der DB unter anderern Namen, dann per TSQL die Daten in der OrigDb wieder update mit den DAten aus der 11 Uhr DB
---aufpassen: Pfade und dateinamen evtl korrigieren.. Fragmentsicherung ausschalten

---2. auf anderen Server restoren
---Bak auf den Server HV-SQL2 kopieren --> ins SQL Backup Verzeichnis



--Fall3 : Restore der DB
--mit geringst m�glichen Datenverlust

---V D ttT 11:04               n�chste Tlog 11:30
--aktuell 11:17:13 --Problem!!!

--- um 11:18 V D  TTT bis 11:04:00   13min
--- warten auf 11:30 T -- V  D TTTT restore von 11:17:12  ...........  alles bis 11:30 weg


--wenn wir weniger faul w�ren:
--T Sicherung um 11:18 (jedes Backup ist Online.. T Sicherung dauert ca 5 min)
--restore von 11:17:12  ---  >ca gut 5 Min Verlust


DB anf�gen und trennen
-- DB Offline, dann ist die DB zwar noch regstriert aber nicht mehrim SQL Prozess 
--DB trennen: DB ist auch aus der master Regsitrierung entfernt worden

--Anf�gen: 
man braucht mind die mdf Datei
eine ldf kann wieder neu erstellt werden




--alle user runterkicken...

--theroetisch
--alle Leute runterwerfen und sollen wegbleiben
--Sicherung des Tlog
--Restore auf gew�nschte Zeit


USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-09-06_11-52-34.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2022-09-06_11-52-34', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 15,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 16,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2022-09-06_11-52-34.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2022-09-06T11:17:12'
ALTER DATABASE [Northwind] SET MULTI_USER

GO



----Fall 4: Einspielen SP UP ... mach vorher ne Sicherung
--Momentaufnahme



-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO


-- Create the database snapshot
CREATE DATABASE SnapshotDBName ON
( NAME = logNamederOrgDatendatei, 
FILENAME = 'PfadundDateiname der Snapshotdatendatei.mdf')
AS SNAPSHOT OF OrgDb;
GO

create database  nw_1400 
ON
(
	NAME=Northwind, --alte mdf
	FILENAME='D:\_SQLDBDATA\nw_1400 .mdf'  --StdPfad des SQL Server
)   as snapshot of northwind


use northwind;
GO

update customers set city = 'BGH' where customerid = 'ALFKI'

select * from customers








--Snapshot-----------------TSQL

--Kann man mehrere SN machen?
--ja

--Kann man einen SN backupen?
--N�

--Kann man die OrgDB backupen?
--Ja klar

select * from Northwind..customers
except
select * from nw_1400..customers


--kann man den SN restoren?
--n�

--kann man die OrgDB restoren?
--jein--kein normaler restore
--f�r den normal restore m�ssen alle SN gel�scht werden
--Restore von SN m�glich

--alle user m�ssen von allen DBs (northwind und Snapshot) verscheucht werden
use master;
GO

restore database northwind
from database_snapshot ='nw_1400'


select * from sysprocesses where spid > 50 and dbid in(11,5)

select db_id('nw_1400')

kill 56







---Gr��e der DB: 100 GB --> V mit kompresion: 20GB
--ArbZeiten:  Mo bis So  24*7
--Ausfallzeit der DB:  4 Std
--Datenverlust: max 15min


--V: t�glich  wann: 22 Uhr wie lange: 1GB / min
--T: alle 15min
--D: TTTT D TTTTTD  TTTTT D TTTT D TTT D TTTT


---Gr��e der DB: 100 GB --> V mit kompresion: 20GB  --- HADR
--ArbZeiten:  Mo bis So  24*7
--Ausfallzeit der DB:  30min
--Datenverlust: max 15min






kill 63

use nw_1400
















 













*/
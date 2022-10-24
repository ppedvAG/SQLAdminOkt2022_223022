---Operatoren = Adressliste (Email/Pager)


--operator in Job hinzufügen

--Emailversand

--Mailserver SMTP
-- (SMTP Server    Port:    Auth) ) Mailprofil  SQLLOCAL

--> zugriff--> Realy...  IP 127.0.0.1 hinzufügen

exec msdb..sp_send_dbmail ...


Mrx@sql.local
--DatenbankEmail

msdb--> Gruppe MailuserRole
--> gast wurde Zugriff gewährt

--- Agent soll Mail versenden
1.  Eigenschaften des Agent--> MailProfil aktivieren unter Warnungssystem
2. Agent neu starten

--Für SQL 2014 und früher
msdb--> Sicherheit--> Rollen-->Datenbankrollen--> DatebaseMailuserRole





---Operatoren = Adressliste (Email/Pager)


--operator in Job hinzuf�gen

--Emailversand

--Mailserver SMTP
-- (SMTP Server    Port:    Auth) ) Mailprofil  SQLLOCAL

--> zugriff--> Realy...  IP 127.0.0.1 hinzuf�gen

exec msdb..sp_send_dbmail ...


Mrx@sql.local
--DatenbankEmail

msdb--> Gruppe MailuserRole
--> gast wurde Zugriff gew�hrt

--- Agent soll Mail versenden
1.  Eigenschaften des Agent--> MailProfil aktivieren unter Warnungssystem
2. Agent neu starten

--F�r SQL 2014 und fr�her
msdb--> Sicherheit--> Rollen-->Datenbankrollen--> DatebaseMailuserRole





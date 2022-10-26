--VerwaisterUser JamesBond in WhoamiDB

/*
OrgServer ist futsch....

1.  wenn wir nur über Rollen arbeiten--> JamesBond löschen und neu anlegen und in Rolle wieder einfügen

2. Neues login anlegen .. klappt nicht.. wg anderer SID

3. 
*/

use whoamiDB;
GO

sp_change_users_login 'Report' --verweaiste USer

sp_change_users_login 'Auto_fix', 'JamesBond', NULL, 'ppedv2019!' --wenn kein Login vorhanden

sp_change_users_login 'Update_one', 'JamesBond', 'JamesBond'--wenn  Login vorhanden

--Wenn der alte Server noch vorhanden wäre


sp_help_revlogin


IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = N'Susi')
                  BEGIN
CREATE LOGIN [Susi] WITH PASSWORD = 0x020023EAB1A3006A9F6DE182CE216DD105DE710CED5CD1263623E36EE08BC0BD8B7B7B2C91B4604AA406C418E6D29A1BF4B77D48A0635081AB9670D1D7E86E62C2F3B4F91401 HASHED, SID = 0x9FB6E8CBCCF4954890A6D20EA092CC75, DEFAULT_DATABASE = [Northwind], DEFAULT_LANGUAGE = [Deutsch], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
 
END





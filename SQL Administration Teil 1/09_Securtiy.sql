USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [Lisa]    Script Date: 25.10.2022 16:22:14 ******/
CREATE LOGIN [Lisa] WITH PASSWORD=N'nO4n1j9Ta9AcDYmTYp6SU/KY7qWNzByA5FRYQEwS5jo=', DEFAULT_DATABASE=[Northwind], DEFAULT_LANGUAGE=[Deutsch], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO



USE [Northwind]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]


CREATE SCHEMA [IT]  AUTHORIZATION [dbo]
GO

USE [Northwind]
GO

/****** Object:  Schema [IT]    Script Date: 25.10.2022 16:14:51 ******/
CREATE SCHEMA [IT]
GO

CREATE SCHEMA [FE]
GO --dbo istt Standard




create table it.personal(itperso int)
create table it.projekte (itpro int)

create table ma.personal(maperso int)
create table ma.projekte (mapro int)



USE [master]
GO
CREATE LOGIN [Fritz] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Fritz] FOR LOGIN [Fritz]
GO
USE [Northwind]
GO
ALTER USER [Fritz] WITH DEFAULT_SCHEMA=[IT]
GO


use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Fritz]
GO

use northwind
GO

--STDSCHEMA: dbo
select * from orders
select * from dbo.orders

select * from ma.personal
#


USE [Northwind]
GO
CREATE ROLE [ITler] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITler] ADD MEMBER [Fritz]
GO

---NEUER MITARBEITER GUSTAV-------------------
USE [master]
GO
CREATE LOGIN [Gustav] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Gustav] FOR LOGIN [Gustav]
GO
USE [Northwind]
GO
ALTER USER [Gustav] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITler] ADD MEMBER [Gustav]
GO

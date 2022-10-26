--ContainedDB
--Fehler :  muss gesetzt werden : contained database authentication', N'1'

EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

select @@MICROSOFTVERSION


USE [ContDB]
GO
CREATE USER [Otto] WITH PASSWORD=N'ppedv2019!'
GO


USE [master]
GO
ALTER DATABASE [ContDB] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO

--keine Replikation, kein CDC CDT

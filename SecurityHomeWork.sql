--1.)

--USE [master]
--GO
--CREATE LOGIN [Mark] WITH PASSWORD=N'1234', DEFAULT_DATABASE=[SportingGoodsStoreDB], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
--GO
--USE [SportingGoodsStoreDB]
--GO
--CREATE USER [Mark] FOR LOGIN [Mark]
--GO
--USE [SportingGoodsStoreDB]
--GO
--ALTER USER [Mark] WITH DEFAULT_SCHEMA=[db_datareader]
--GO

USE [SportingGoodsStoreDB]
GO

ALTER ROLE [db_datareader] ADD MEMBER [Mark]
GO

ALTER ROLE [db_datawriter] ADD MEMBER [Mark]
GO

DENY SELECT ON [dbo].[Employees] TO [Mark]
GO

--2.)

--USE [master]
--GO
--CREATE LOGIN [David] WITH PASSWORD=N'1234', DEFAULT_DATABASE=[SportingGoodsStoreDB], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
--GO
--USE [SportingGoodsStoreDB]
--GO
--CREATE USER [David] FOR LOGIN [David]
--GO
--USE [SportingGoodsStoreDB]
--GO
--ALTER USER [David] WITH DEFAULT_SCHEMA=[db_datareader]
--GO

use [SportingGoodsStoreDB]
GO
GRANT CONTROL, SELECT, VIEW CHANGE TRACKING, VIEW DEFINITION  ON [dbo].[Employees] TO [David]
GO

--3.)

--USE [master]
--GO
--CREATE LOGIN [Olga] WITH PASSWORD=N'1234' MUST_CHANGE, DEFAULT_DATABASE=[SportingGoodsStoreDB], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
--GO
--USE [SportingGoodsStoreDB]
--GO
--CREATE USER [Olga] FOR LOGIN [Olga]
--GO
--USE [SportingGoodsStoreDB]
--GO
--ALTER USER [Olga] WITH DEFAULT_SCHEMA=[db_owner]
--GO

USE [SportingGoodsStoreDB]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_owner] TO [Olga]
GO
USE [SportingGoodsStoreDB]
GO
ALTER ROLE [db_owner] ADD MEMBER [Olga]
GO


--4.)

--USE [master]
--GO
--CREATE LOGIN [Konstyantyn] WITH PASSWORD=N'1234', DEFAULT_DATABASE=[SportingGoodsStoreDB], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
--GO
--USE [SportingGoodsStoreDB]
--GO
--CREATE USER [Konstyantyn] FOR LOGIN [Konstyantyn]
--GO
--USE [SportingGoodsStoreDB]
--GO
--ALTER USER [Konstyantyn] WITH DEFAULT_SCHEMA=[db_datareader]
--GO

use [SportingGoodsStoreDB]
GO
GRANT
CONTROL, SELECT, VIEW CHANGE TRACKING, VIEW DEFINITION
	ON [dbo].[Employees] TO [Konstyantyn]
GO

GRANT
CONTROL, SELECT, VIEW CHANGE TRACKING, VIEW DEFINITION
	ON [dbo].[Goods] TO [Konstyantyn]
GO
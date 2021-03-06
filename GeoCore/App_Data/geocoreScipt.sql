USE [master]
GO
/****** Object:  Database [GeoCore]    Script Date: 10/29/2014 11:52:23 AM ******/
CREATE DATABASE [GeoCore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GeoCore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GeoCore.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GeoCore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GeoCore_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GeoCore] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GeoCore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GeoCore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GeoCore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GeoCore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GeoCore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GeoCore] SET ARITHABORT OFF 
GO
ALTER DATABASE [GeoCore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GeoCore] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [GeoCore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GeoCore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GeoCore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GeoCore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GeoCore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GeoCore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GeoCore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GeoCore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GeoCore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GeoCore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GeoCore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GeoCore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GeoCore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GeoCore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GeoCore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GeoCore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GeoCore] SET RECOVERY FULL 
GO
ALTER DATABASE [GeoCore] SET  MULTI_USER 
GO
ALTER DATABASE [GeoCore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GeoCore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GeoCore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GeoCore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GeoCore', N'ON'
GO
USE [GeoCore]
GO
/****** Object:  User [GeoCore]    Script Date: 10/29/2014 11:52:23 AM ******/
CREATE USER [GeoCore] FOR LOGIN [GeoCore] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [GeoCore]
GO
/****** Object:  Schema [GeoCore]    Script Date: 10/29/2014 11:52:23 AM ******/
CREATE SCHEMA [GeoCore]
GO
/****** Object:  StoredProcedure [GeoCore].[GetSiteConfiguration]    Script Date: 10/29/2014 11:52:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Josh Pierro 
-- Create date: 10/28/2014
-- Description:	a stored proc to get site configuration settings 
-- =============================================
CREATE PROCEDURE [GeoCore].[GetSiteConfiguration]
	
AS
BEGIN
	SELECT TOP 1 ConfigId, SiteName, ZoomLevel, StartLatitude, StartLongitude, BaseMap FROM [GeoCore].[SiteConfig]
END

GO
/****** Object:  StoredProcedure [GeoCore].[SaveConfig]    Script Date: 10/29/2014 11:52:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Josh Pierro 
-- Create date: 10/28/2014
-- Description:	a stored proc to store site configuration settings 
-- =============================================
CREATE PROCEDURE [GeoCore].[SaveConfig]
	@SiteName VARCHAR(25), 
	@ZoomLevel INT, 
	@StartLatitude FLOAT,
	@StartLongitude FLOAT, 
	@BaseMap  VARCHAR(55)
AS
BEGIN

    TRUNCATE TABLE [GeoCore].[SiteConfig]

	INSERT INTO [GeoCore].[SiteConfig]
           ([SiteName]
           ,[ZoomLevel]
           ,[StartLatitude]
           ,[StartLongitude]
           ,[BaseMap])
     VALUES
           (@SiteName
           ,@ZoomLevel
           ,@StartLatitude 
           ,@StartLongitude
           ,@BaseMap )
END

GO
/****** Object:  Table [GeoCore].[SiteConfig]    Script Date: 10/29/2014 11:52:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [GeoCore].[SiteConfig](
	[ConfigId] [int] IDENTITY(1,1) NOT NULL,
	[SiteName] [varchar](55) NULL,
	[ZoomLevel] [int] NULL,
	[StartLatitude] [float] NULL,
	[StartLongitude] [float] NULL,
	[BaseMap] [varchar](55) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [GeoCore].[SiteConfig] ON 

INSERT [GeoCore].[SiteConfig] ([ConfigId], [SiteName], [ZoomLevel], [StartLatitude], [StartLongitude], [BaseMap]) VALUES (1, N'startup', 14, 40.716753242474262, -73.999485969543457, N'Grey Canvas')
SET IDENTITY_INSERT [GeoCore].[SiteConfig] OFF
USE [master]
GO
ALTER DATABASE [GeoCore] SET  READ_WRITE 
GO

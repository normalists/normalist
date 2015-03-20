USE [master]
GO

/****** Object:  Database [Normalist]    Script Date: 20.03.2015 19:51:07 ******/
CREATE DATABASE [Normalist]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Normalist', FILENAME = N'E:\Data\Normalist.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Normalist_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.AGRONET\MSSQL\DATA\Normalist_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [Normalist] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Normalist].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Normalist] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Normalist] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Normalist] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Normalist] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Normalist] SET ARITHABORT OFF 
GO

ALTER DATABASE [Normalist] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Normalist] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [Normalist] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Normalist] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Normalist] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Normalist] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Normalist] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Normalist] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Normalist] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Normalist] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Normalist] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Normalist] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Normalist] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Normalist] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Normalist] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Normalist] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Normalist] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Normalist] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Normalist] SET RECOVERY FULL 
GO

ALTER DATABASE [Normalist] SET  MULTI_USER 
GO

ALTER DATABASE [Normalist] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Normalist] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Normalist] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Normalist] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [Normalist] SET  READ_WRITE 
GO



USE [master]
GO

/****** Object:  Database [QuizBaker]    Script Date: 03/30/2012 09:38:19 ******/
CREATE DATABASE [QuizBaker] ON  PRIMARY 
( NAME = N'QuizBaker', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\QuizBaker.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuizBaker_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\QuizBaker_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [QuizBaker] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuizBaker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [QuizBaker] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [QuizBaker] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [QuizBaker] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [QuizBaker] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [QuizBaker] SET ARITHABORT OFF 
GO

ALTER DATABASE [QuizBaker] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [QuizBaker] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [QuizBaker] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [QuizBaker] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [QuizBaker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [QuizBaker] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [QuizBaker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [QuizBaker] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [QuizBaker] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [QuizBaker] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [QuizBaker] SET  DISABLE_BROKER 
GO

ALTER DATABASE [QuizBaker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [QuizBaker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [QuizBaker] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [QuizBaker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [QuizBaker] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [QuizBaker] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [QuizBaker] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [QuizBaker] SET  READ_WRITE 
GO

ALTER DATABASE [QuizBaker] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [QuizBaker] SET  MULTI_USER 
GO

ALTER DATABASE [QuizBaker] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [QuizBaker] SET DB_CHAINING OFF 
GO





USE [QuizBaker]
GO
/****** Object:  User [student]    Script Date: 03/30/2012 09:37:54 ******/
CREATE USER [student] FOR LOGIN [BUILTIN\Users]
GO
/****** Object:  User [web]    Script Date: 03/30/2012 09:37:54 ******/
CREATE USER [web] FOR LOGIN [web] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 03/30/2012 09:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Achternaam] [nvarchar](255) NULL,
	[Voornaam] [nvarchar](255) NULL,
	[Klas] [nvarchar](255) NULL,
	[Nummer] [nvarchar](255) NULL,
	[Unit] [nvarchar](255) NULL,
	[Photo] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz_Summary]    Script Date: 03/30/2012 09:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz_Summary](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[quiz_id] [int] NULL,
	[lastmodified] [datetime] NULL,
	[network_id] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[raw_score] [nvarchar](50) NULL,
	[passing_score] [nvarchar](50) NULL,
	[max_score] [nvarchar](50) NULL,
	[min_score] [nvarchar](50) NULL,
	[time] [nvarchar](50) NULL,
	[klas] [nvarchar](50) NULL,
 CONSTRAINT [PK_Quiz_Summary] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz_Detail]    Script Date: 03/30/2012 09:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz_Detail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[summary_id] [int] NOT NULL,
	[lastmodified] [datetime] NULL,
	[timestamp] [datetime] NULL,
	[score] [nvarchar](50) NULL,
	[interaction_id] [nvarchar](50) NULL,
	[objective_id] [nvarchar](50) NULL,
	[interaction_type] [nvarchar](50) NULL,
	[student_response] [nvarchar](max) NULL,
	[result] [nvarchar](50) NULL,
	[weight] [nvarchar](50) NULL,
	[latency] [nvarchar](50) NULL,
	[question] [nvarchar](max) NULL,
 CONSTRAINT [PK_Quiz_Detail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 03/30/2012 09:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quiz](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[quizname] [nvarchar](100) NULL,
 CONSTRAINT [PK_Quiz] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwSummary]    Script Date: 03/30/2012 09:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwSummary]
AS
SELECT     dbo.Quiz_Summary.ID, dbo.Quiz_Summary.quiz_id, dbo.Quiz_Summary.lastmodified, dbo.Quiz_Summary.network_id, dbo.Quiz_Summary.status, 
                      dbo.Quiz_Summary.raw_score, dbo.Quiz_Summary.passing_score, dbo.Quiz_Summary.max_score, dbo.Quiz_Summary.min_score, dbo.Quiz_Summary.time, 
                      dbo.Students.Achternaam, dbo.Students.Voornaam, dbo.Students.Nummer, dbo.Students.Unit, dbo.Students.Photo, dbo.Quiz.quizname, 
                      dbo.Quiz_Summary.klas AS CurrentClass, dbo.Students.Klas
FROM         dbo.Quiz_Summary INNER JOIN
                      dbo.Students ON dbo.Quiz_Summary.network_id = 'COLEGIO-EPI\' + dbo.Students.Nummer INNER JOIN
                      dbo.Quiz ON dbo.Quiz_Summary.quiz_id = dbo.Quiz.ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Quiz_Summary"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 289
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Students"
            Begin Extent = 
               Top = 98
               Left = 259
               Bottom = 281
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Quiz"
            Begin Extent = 
               Top = 6
               Left = 451
               Bottom = 95
               Right = 611
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSummary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwSummary'
GO
/****** Object:  View [dbo].[vwDetails]    Script Date: 03/30/2012 09:37:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwDetails]
AS
SELECT     dbo.Quiz.ID AS quizId, dbo.Quiz_Detail.ID, dbo.Quiz_Detail.summary_id, dbo.Quiz_Detail.lastmodified, dbo.Quiz_Detail.timestamp, dbo.Quiz_Detail.score, 
                      dbo.Quiz_Detail.interaction_id, dbo.Quiz_Detail.objective_id, LEFT(SUBSTRING(dbo.Quiz_Detail.objective_id, 9, 5), LEN(dbo.Quiz_Detail.objective_id) - 10) 
                      AS questionNum, dbo.Quiz_Detail.interaction_type, dbo.Quiz_Detail.student_response, dbo.Quiz_Detail.result, dbo.Quiz_Detail.weight, dbo.Quiz_Detail.latency, 
                      dbo.Quiz_Detail.question, dbo.Quiz_Summary.raw_score, dbo.Quiz.quizname, dbo.Students.Achternaam, dbo.Students.Voornaam, dbo.Students.Klas, 
                      dbo.Students.Nummer, dbo.Students.Photo, dbo.Quiz_Summary.klas AS CurrentClass
FROM         dbo.Quiz INNER JOIN
                      dbo.Quiz_Summary ON dbo.Quiz.ID = dbo.Quiz_Summary.quiz_id INNER JOIN
                      dbo.Quiz_Detail ON dbo.Quiz_Summary.ID = dbo.Quiz_Detail.summary_id INNER JOIN
                      dbo.Students ON dbo.Quiz_Summary.network_id = 'COLEGIO-EPI\' + dbo.Students.Nummer
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -134
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Quiz"
            Begin Extent = 
               Top = 13
               Left = 579
               Bottom = 143
               Right = 739
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Quiz_Summary"
            Begin Extent = 
               Top = 175
               Left = 421
               Bottom = 331
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "Quiz_Detail"
            Begin Extent = 
               Top = 8
               Left = 219
               Bottom = 127
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Students"
            Begin Extent = 
               Top = 119
               Left = 38
               Bottom = 303
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vwDetails'
GO

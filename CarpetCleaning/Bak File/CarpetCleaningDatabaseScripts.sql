USE [master]
GO
/****** Object:  Database [CarpetCleaning]    Script Date: 12/22/2022 7:00:47 PM ******/
CREATE DATABASE [CarpetCleaning]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CarpetCleaning', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CarpetCleaning.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CarpetCleaning_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CarpetCleaning_log.ldf' , SIZE = 1187840KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CarpetCleaning] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CarpetCleaning].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CarpetCleaning] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CarpetCleaning] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CarpetCleaning] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CarpetCleaning] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CarpetCleaning] SET ARITHABORT OFF 
GO
ALTER DATABASE [CarpetCleaning] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CarpetCleaning] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CarpetCleaning] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CarpetCleaning] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CarpetCleaning] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CarpetCleaning] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CarpetCleaning] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CarpetCleaning] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CarpetCleaning] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CarpetCleaning] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CarpetCleaning] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CarpetCleaning] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CarpetCleaning] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CarpetCleaning] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CarpetCleaning] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CarpetCleaning] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CarpetCleaning] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CarpetCleaning] SET RECOVERY FULL 
GO
ALTER DATABASE [CarpetCleaning] SET  MULTI_USER 
GO
ALTER DATABASE [CarpetCleaning] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CarpetCleaning] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CarpetCleaning] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CarpetCleaning] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CarpetCleaning] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CarpetCleaning] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CarpetCleaning', N'ON'
GO
ALTER DATABASE [CarpetCleaning] SET QUERY_STORE = OFF
GO
USE [CarpetCleaning]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[MilesfromSTL] [decimal](18, 2) NULL,
 CONSTRAINT [PK__City__F2D21A96E67703C7] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[AddressNumber] [binary](32) NOT NULL,
	[Street] [varchar](100) NOT NULL,
	[Apt] [varchar](50) NULL,
	[CityID] [int] NOT NULL,
	[State] [char](2) NOT NULL,
	[Zipcode] [int] NOT NULL,
 CONSTRAINT [PK__Addresse__091C2A1B354C68EC] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Technicians]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Technicians](
	[TechnicianID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Technici__301F82C1B3E3CFC6] PRIMARY KEY CLUSTERED 
(
	[TechnicianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jobs]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jobs](
	[JobID] [int] IDENTITY(1,1) NOT NULL,
	[TechnicianID] [int] NOT NULL,
	[AddressID] [int] NOT NULL,
	[Discount] [money] NULL,
	[Total] [money] NOT NULL,
	[JobDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceTypes]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceTypes](
	[ServiceTypeID] [int] NOT NULL,
	[ServiceTypeCategoryID] [int] NOT NULL,
	[ServiceName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JobDetails]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JobDetails](
	[JobDetailID] [int] IDENTITY(1,1) NOT NULL,
	[JobID] [int] NOT NULL,
	[ServiceTypeID] [int] NOT NULL,
	[Amount] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JobDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[JobSpecifics]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[JobSpecifics] AS
SELECT * from(
Select j.Jobid, j.JobDate, t.[Name], A.AddressNumber, A.Street, A.Apt, C.City, A.State, A.Zipcode, J.Total,J.Discount, Jd.Amount, St.ServiceName
from DBO.Jobs j
JOIN DBO.Technicians T on t.TechnicianID = j.TechnicianID
JOIN DBO.Addresses A on A.AddressID = J.AddressID
JOIN DBO.Cities C on C.CityID = A.CityID
JOIN DBO.JobDetails jd on jd.JobID = J.JobID
JOIN DBO.ServiceTypes st on st.ServiceTypeID = jd.ServiceTypeID
)T
PIVOT(
	SUM(Amount)
	For ServiceName in (
		Carpet,
		UrineTreatment,
		Protectant,
		Upholstery,
		AirDucts,
		Tile,
		DryerVent,
		Other)
) AS Pivot_table;


GO
/****** Object:  Table [dbo].[ExcelDataErrors]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExcelDataErrors](
	[Errorid] [int] IDENTITY(1,1) NOT NULL,
	[ExcelDataRowId] [int] NULL,
	[ErrorMessage] [varchar](max) NULL,
 CONSTRAINT [PK__Exceldat__35F05FA2584A9B15] PRIMARY KEY CLUSTERED 
(
	[Errorid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jobs_ExcelData]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jobs_ExcelData](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[JobDate] [date] NULL,
	[TechnicianName] [char](15) NULL,
	[AddressNumber] [int] NULL,
	[Street] [varchar](100) NULL,
	[Apt] [varchar](50) NULL,
	[City] [varchar](30) NULL,
	[State] [char](2) NULL,
	[Zipcode] [int] NULL,
	[Total] [money] NULL,
	[Discount] [money] NULL,
	[Carpet] [money] NULL,
	[Urinetreatment] [money] NULL,
	[Protectant] [money] NULL,
	[Upholstery] [money] NULL,
	[AirDucts] [money] NULL,
	[Tile] [money] NULL,
	[DryerVent] [money] NULL,
	[Other] [money] NULL,
	[LoadDataNotes] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceTypeCategories]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceTypeCategories](
	[ServiceTypeCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceTypeCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (1, N'Saint Louis', CAST(0.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (2, N'East Saint Louis', CAST(2.54 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (3, N'Venice', CAST(3.46 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (4, N'Cahokia', CAST(3.92 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (5, N'Madison', CAST(4.41 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (6, N'Alorton', CAST(4.93 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (7, N'Centreville', CAST(4.96 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (8, N'Washington Park', CAST(5.69 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (9, N'Granite City', CAST(5.77 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (10, N'Fairmont City', CAST(5.86 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (11, N'Hillsdale', CAST(6.05 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (12, N'Pine Lawn', CAST(6.31 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (13, N'Wellston', CAST(6.31 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (14, N'University City', CAST(6.33 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (15, N'Velda Village Hills', CAST(6.52 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (16, N'Richmond Heights', CAST(6.57 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (17, N'Velda Village', CAST(6.77 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (18, N'Clayton', CAST(6.87 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (19, N'Maplewood', CAST(6.91 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (20, N'Northwoods', CAST(7.04 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (21, N'Pagedale', CAST(7.08 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (22, N'Jennings', CAST(7.19 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (23, N'Charlack', CAST(9.42 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (24, N'Castle Point', CAST(9.44 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (25, N'Pontoon Beach', CAST(9.61 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (26, N'Lakeshire', CAST(9.61 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (27, N'Dellwood', CAST(9.68 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (28, N'Saint Johns', CAST(9.84 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (29, N'Rock Hill', CAST(9.84 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (30, N'Glendale', CAST(9.91 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (31, N'Ferguson', CAST(9.95 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (32, N'Olivette', CAST(9.96 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (33, N'Ladue', CAST(9.99 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (34, N'Warson Woods', CAST(10.11 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (35, N'Overland', CAST(10.24 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (36, N'Green Park', CAST(10.44 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (37, N'Mehlville', CAST(10.63 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (38, N'Oakland', CAST(10.73 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (39, N'Breckenridge Hills', CAST(10.95 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (40, N'Woodson Terrace', CAST(10.98 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (41, N'Crestwood', CAST(11.05 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (42, N'Mitchell', CAST(11.11 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (43, N'Spanish Lake', CAST(11.14 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (44, N'Concord', CAST(11.16 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (45, N'Berkeley', CAST(11.36 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (46, N'Calverton Park', CAST(11.37 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (47, N'Fairview Heights', CAST(11.51 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (48, N'Sappington', CAST(11.64 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (49, N'Kirkwood', CAST(11.68 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (50, N'Frontenac', CAST(11.74 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (51, N'Collinsville', CAST(11.89 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (52, N'Black Jack', CAST(12.07 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (53, N'Saint Ann', CAST(12.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (54, N'Oakville', CAST(12.30 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (55, N'Creve Coeur', CAST(12.35 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (56, N'Columbia', CAST(12.69 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (57, N'Millstadt', CAST(12.81 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (58, N'Des Peres', CAST(12.82 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (59, N'Sunset Hills', CAST(12.85 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (60, N'Swansea', CAST(13.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (61, N'Florissant', CAST(13.06 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (62, N'Hazelwood', CAST(13.65 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (63, N'Belleville', CAST(13.73 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (64, N'Maryland Heights', CAST(13.85 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (65, N'Glen Carbon', CAST(14.29 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (66, N'Town and Country', CAST(14.37 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (67, N'Maryville', CAST(14.65 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (68, N'Bridgeton', CAST(15.03 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (69, N'Fenton', CAST(15.09 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (70, N'Hartford', CAST(15.27 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (71, N'O''Fallon', CAST(15.67 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (72, N'South Roxana', CAST(15.75 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (73, N'Arnold', CAST(16.58 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (74, N'Roxana', CAST(16.63 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (75, N'Valley Park', CAST(16.81 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (76, N'Shiloh', CAST(16.86 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (77, N'Manchester', CAST(16.94 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (78, N'Wood River', CAST(17.04 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (79, N'Winchester', CAST(18.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (80, N'East Alton', CAST(18.10 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (81, N'Alton', CAST(18.21 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (82, N'Murphy', CAST(18.27 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (83, N'Edwardsville', CAST(18.33 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (84, N'Troy', CAST(18.38 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (85, N'Saint Charles', CAST(18.72 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (86, N'Smithton', CAST(18.76 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (87, N'Ballwin', CAST(18.94 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (88, N'Rosewood Heights', CAST(19.01 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (89, N'Scott Air Force Base', CAST(19.66 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (90, N'Upper Alton', CAST(19.80 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (91, N'Imperial', CAST(20.30 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (92, N'Waterloo', CAST(20.30 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (93, N'Chesterfield', CAST(20.61 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (94, N'Freeburg', CAST(20.65 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (95, N'Clarkson Valley', CAST(21.14 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (96, N'Lebanon', CAST(21.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (97, N'Ellisville', CAST(21.15 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (98, N'Bethalto', CAST(21.24 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (99, N'High Ridge', CAST(21.68 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (100, N'Barnhart', CAST(22.24 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (101, N'Valmeyer', CAST(22.63 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (102, N'Godfrey', CAST(22.69 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (103, N'Mascoutah', CAST(23.83 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (104, N'Saint Jacob', CAST(23.94 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (105, N'Byrnes Mill', CAST(24.53 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (106, N'Holiday Shores', CAST(24.63 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (107, N'Eureka', CAST(24.78 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (108, N'Wildwood', CAST(25.30 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (109, N'Riverside', CAST(25.51 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (110, N'Cottleville', CAST(25.94 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (111, N'Saint Peters', CAST(26.02 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (112, N'Pevely', CAST(26.05 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (113, N'Herculaneum', CAST(26.69 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (114, N'New Athens', CAST(27.08 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (115, N'Weldon Spring', CAST(27.17 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (116, N'New Baden', CAST(27.60 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (117, N'Trenton', CAST(27.89 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (118, N'Worden', CAST(28.56 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (119, N'Brighton', CAST(28.67 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (120, N'Highland', CAST(29.45 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (121, N'Crystal City', CAST(29.72 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (122, N'O''Fallon', CAST(29.88 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (123, N'Festus', CAST(30.08 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (124, N'Dardenne Prairie', CAST(30.28 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (125, N'Cedar Hill', CAST(30.55 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (126, N'Red Bud', CAST(30.76 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (127, N'Pacific', CAST(31.04 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (128, N'Bunker Hill', CAST(31.62 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (129, N'Aviston', CAST(31.90 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (130, N'Albers', CAST(32.16 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (131, N'Saint Paul', CAST(33.48 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (132, N'Hillsboro', CAST(33.69 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (133, N'Lake Saint Louis', CAST(33.81 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (134, N'Staunton', CAST(34.45 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (135, N'Gray Summit', CAST(34.76 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (136, N'Jerseyville', CAST(34.77 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (137, N'Marissa', CAST(35.59 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (138, N'Germantown', CAST(35.98 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (139, N'Breese', CAST(36.24 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (140, N'Okawville', CAST(37.46 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (141, N'Wentzville', CAST(37.54 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (142, N'Benld', CAST(38.52 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (143, N'Villa Ridge', CAST(38.73 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (144, N'Winfield', CAST(38.74 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (145, N'De Soto', CAST(38.86 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (146, N'Moscow Mills', CAST(51.70 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (147, N'Warrenton', CAST(56.70 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (148, N'Brentwood', CAST(9.30 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (149, N'Defiance', CAST(37.90 AS Decimal(18, 2)))
GO
INSERT [dbo].[Cities] ([CityID], [City], [MilesfromSTL]) VALUES (150, N'Wright City', CAST(50.30 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[ServiceTypeCategories] ON 
GO
INSERT [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID], [Name]) VALUES (1, N'Carpet')
GO
INSERT [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID], [Name]) VALUES (2, N'Upholstery')
GO
INSERT [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID], [Name]) VALUES (3, N'Vents and Ducts')
GO
INSERT [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID], [Name]) VALUES (4, N'Tile and Stone')
GO
INSERT [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID], [Name]) VALUES (5, N'Other')
GO
SET IDENTITY_INSERT [dbo].[ServiceTypeCategories] OFF
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (1, 1, N'Carpet')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (2, 1, N'UrineTreatment')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (3, 1, N'Protectant')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (4, 1, N'CarpetStretchingandRepair')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (5, 1, N'Disinfectant_Deodorizer')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (6, 1, N'Spotting')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (7, 2, N'Upholstery')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (8, 2, N'VehicleUpholstery_Carpet')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (9, 3, N'AirDucts')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (10, 3, N'Fogging')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (11, 3, N'DryerVent')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (12, 4, N'Tile')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (13, 4, N'TileandGroutShower')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (14, 4, N'Sealant')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (15, 4, N'ConcreteFloor')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (16, 5, N'WoodFloors')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (17, 5, N'Padreplacement')
GO
INSERT [dbo].[ServiceTypes] ([ServiceTypeID], [ServiceTypeCategoryID], [ServiceName]) VALUES (18, 5, N'Other')
GO
SET IDENTITY_INSERT [dbo].[Technicians] ON 
GO
INSERT [dbo].[Technicians] ([TechnicianID], [Name]) VALUES (1, N'Ray')
GO
INSERT [dbo].[Technicians] ([TechnicianID], [Name]) VALUES (2, N'Mitchell')
GO
INSERT [dbo].[Technicians] ([TechnicianID], [Name]) VALUES (3, N'Zeke')
GO
INSERT [dbo].[Technicians] ([TechnicianID], [Name]) VALUES (4, N'Tom')
GO
SET IDENTITY_INSERT [dbo].[Technicians] OFF
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK__Addresses__CityI__534D60F1] FOREIGN KEY([CityID])
REFERENCES [dbo].[Cities] ([CityID])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK__Addresses__CityI__534D60F1]
GO
ALTER TABLE [dbo].[ExcelDataErrors]  WITH CHECK ADD  CONSTRAINT [FK__Exceldata__Excel__19DFD96B] FOREIGN KEY([ExcelDataRowId])
REFERENCES [dbo].[Jobs_ExcelData] ([RowId])
GO
ALTER TABLE [dbo].[ExcelDataErrors] CHECK CONSTRAINT [FK__Exceldata__Excel__19DFD96B]
GO
ALTER TABLE [dbo].[JobDetails]  WITH CHECK ADD FOREIGN KEY([ServiceTypeID])
REFERENCES [dbo].[ServiceTypes] ([ServiceTypeID])
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK__Jobs__AddressID__571DF1D5] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK__Jobs__AddressID__571DF1D5]
GO
ALTER TABLE [dbo].[Jobs]  WITH CHECK ADD  CONSTRAINT [FK__Jobs__Technician__5629CD9C] FOREIGN KEY([TechnicianID])
REFERENCES [dbo].[Technicians] ([TechnicianID])
GO
ALTER TABLE [dbo].[Jobs] CHECK CONSTRAINT [FK__Jobs__Technician__5629CD9C]
GO
ALTER TABLE [dbo].[ServiceTypes]  WITH CHECK ADD FOREIGN KEY([ServiceTypeCategoryID])
REFERENCES [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID])
GO
/****** Object:  StoredProcedure [dbo].[BulkInsertCarpetdata]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[BulkInsertCarpetdata] 
	
AS
BEGIN
	SET IDENTITY_INSERT dbo.Technicians ON;  
   
	Bulk insert dbo.exceldata
	from 'C:\Users\rwpul\Downloads\Carpet Cleaning Database - ExcelSheet (1).csv'
	with
	(format = 'CSV',
	Firstrow = 2, 
	KeepIdentity)
  

SET IDENTITY_INSERT dbo.Technicians OFF;  

END
GO
/****** Object:  StoredProcedure [dbo].[JobDetails_BulkInsert]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[JobDetails_BulkInsert] 
	@FilePath nvarchar(max)
AS
BEGIN
   
	DECLARE @SQL nvarchar(max) = 'BULK INSERT CarpetCleaning.dbo.Jobs_ExcelData FROM ''' + @FilePath + ''' WITH (FORMAT = ''CSV'', Firstrow = 2)'
	EXECUTE sp_executesql @SQL

END
GO
/****** Object:  StoredProcedure [dbo].[JobDetails_ETL_SoupToNuts]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[JobDetails_ETL_SoupToNuts]
	@FilePath nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;

    EXEC dbo.JobDetails_BulkInsert @FilePath
	EXEC dbo.JobDetails_ValidateExcelData
	EXEC dbo.JobDetails_LoadExcelData

END
GO
/****** Object:  StoredProcedure [dbo].[JobDetails_LoadExcelData]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[JobDetails_LoadExcelData]
AS
BEGIN

    WHILE ((SELECT COUNT(*) FROM dbo.Jobs_ExcelData WHERE LoadDataNotes = 'Passed Validation') > 0)
    BEGIN

        DECLARE @ThisRowId INT, 
                @AddressID INT,
                @JobID INT

        DECLARE @CarpetCleaningServiceTypeId INT = 1,
                @UrineTreatmentServiceTypeId INT = 2,
                @ProtectantServiceTypeId INT = 3,
                @UpholsteryServiceTypeId INT = 7,
                @AirDuctsServiceTypeId INT = 9,
                @TileServiceTypeId INT = 12,
                @DryerVentServiceTypeId INT = 11,
                @OtherServiceTypeId INT = 18
                    
            --Inserts FROM the top row and works its way down.
        SELECT TOP 1 @ThisRowId = RowId FROM dbo.Jobs_Exceldata WHERE LoadDataNotes = 'Passed Validation'

        BEGIN TRY

			BEGIN TRANSACTION
            
				INSERT INTO dbo.addresses(AddressNumber, Street, Apt, CityID, [State], Zipcode)
					SELECT Hashbytes('SHA2_256', CAST(e.AddressNumber AS NVARCHAR(100))), 
						e.Street,
						e.Apt, 
						c.cityid,
						e.[State],
						e.Zipcode
					FROM dbo.Jobs_ExcelData e
					JOIN dbo.Cities c ON c.City = e.City
					WHERE c.City = E.City 
						  AND RowId = @ThisRowId
					ORDER BY RowId 

				SET @AddressID = SCOPE_IDENTITY();
                            
				INSERT INTO dbo.Jobs(TechnicianID, AddressID, Discount, Total, JobDate)
					SELECT t.Technicianid, @AddressID, e.Discount, e.Total, e.JobDate
					FROM dbo.Jobs_ExcelData e
					JOIN dbo.Technicians t ON t.[Name] = e.TechnicianName
					WHERE RowId = @ThisRowId

				SET @JobID = SCOPE_IDENTITY();		

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @CarpetCleaningServiceTypeid, e.Carpet
					FROM dbo.Jobs_ExcelData e
					WHERE Rowid = @ThisRowId
						  AND e.Carpet IS NOT NULL AND e.Carpet > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @UrineTreatmentServiceTypeid, e.Urinetreatment
					FROM dbo.Jobs_ExcelData e
					WHERE Rowid = @ThisRowId
						  AND e.Urinetreatment IS NOT NULL AND e.Urinetreatment > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @ProtectantServiceTypeId, e.Protectant
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Protectant IS NOT NULL AND e.Protectant > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @UpholsteryServiceTypeId, e.Upholstery
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Upholstery IS NOT NULL AND e.Upholstery > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @AirDuctsServiceTypeId, e.AirDucts
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.AirDucts IS NOT NULL AND e.AirDucts > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @TileServiceTypeId, e.Tile
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Tile IS NOT NULL AND e.Tile > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @DryerVentServiceTypeId, e.DryerVent
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.DryerVent IS NOT NULL AND e.DryerVent > 0 

				INSERT INTO JobDetails(JobID, ServiceTypeID, Amount)
					SELECT @JobID, @OtherServiceTypeId, e.Other
					FROM dbo.Jobs_Exceldata e
					WHERE Rowid = @ThisRowId
						  AND e.Other IS NOT NULL AND e.Other > 0 

				DELETE FROM dbo.ExcelDataErrors WHERE ExcelDataRowId = @ThisRowId
				DELETE FROM dbo.Jobs_Exceldata WHERE RowId = @ThisRowId

			COMMIT TRANSACTION
        END TRY

        BEGIN CATCH
			DECLARE 
				@ErrorMessage NVARCHAR(255),
				@ErrorSeverity INT,
				@ErrorState INT;
			SELECT 
				@ErrorMessage = ERROR_MESSAGE(),
				@ErrorSeverity = ERROR_SEVERITY(),
				@ErrorState = ERROR_STATE();
       
			INSERT INTO DBO.ExcelDataErrors(ExcelDataRowId, ErrorMessage)
			   SELECT @ThisRowId, @ErrorMessage
			   FROM dbo.Jobs_ExcelData
			   
			UPDATE dbo.Jobs_ExcelData
				SET LoadDataNotes = 'Failure During Load'
				WHERE RowId = @ThisRowId
					 	   
		   RAISERROR (
				@ErrorMessage,
				@ErrorSeverity,
				@ErrorState    
				);
			ROLLBACK TRANSACTION
        END CATCH

	END

END
GO
/****** Object:  StoredProcedure [dbo].[JobDetails_ValidateExcelData]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[JobDetails_ValidateExcelData]
	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE
		@MissingInformationError NVARCHAR(255) = 'Missing information in one or more fields',
		@DuplicateInfoError NVARCHAR(255) = 'Duplicate of invoice',
		@NoServicesError NVARCHAR(255) = 'No services performed',
		@TotalNotMatchError NVARCHAR(255) = 'Amount of services combined does not equal total',
		@NotValidTechnician NVARCHAR(255) = 'Cannot find Technician in table',
		@NotValidCity NVARCHAR(255) = 'City not in Table',
		@NotValidState NVARCHAR(255) = 'State not in Table',
		@WrongZipcode NVARCHAR(255) = 'Wrong number of digits in zip code',
		@PassedValidation NVARCHAR(255) = 'Passed Validation',
		@FailedValidation NVARCHAR(255) = 'Failed Validation'

	--Everytime Validation is run, clean all previous errors off
	UPDATE dbo.Jobs_ExcelData 
	SET LoadDataNotes = NULL
	TRUNCATE TABLE DBO.ExcelDataErrors

		--Clean up empty spaces
	UPDATE dbo.Jobs_ExcelData
		SET TechnicianName = LTRIM(RTRIM(Technicianname)),
		Addressnumber = LTRIM(RTRIM(Addressnumber)),
		Street = LTRIM(RTRIM(Street)),
		Apt = LTRIM(RTRIM(Apt)),
		City = LTRIM(RTRIM(City)),
		[State] = LTRIM(RTRIM([State]))

	--Missing Information
	INSERT INTO dbo.ExcelDataErrors (ExcelDataRowId, ErrorMessage)
		SELECT RowId, @MissinginformationError 
		FROM dbo.Jobs_ExcelData
		WHERE (TechnicianName = '' OR TechnicianName IS NULL)
			OR (Addressnumber = '' OR Addressnumber IS NULL)
			OR (JobDate = '' OR JobDate IS NULL)
			OR (Street = '' OR Street IS NULL)
			OR (City = '' OR City IS NULL)
			OR ([State] = '' OR [State] IS NULL)
			OR (Zipcode = '' OR Zipcode IS NULL)
			OR (Total = '' OR Total IS NULL OR Total = 0)
			
	--Duplicate Invoices
	INSERT INTO dbo.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @DuplicateInfoError 
		FROM (SELECT *, ROW_NUMBER() OVER	
			 (PARTITION BY Jobdate, TechnicianName, Street, Total 
			 ORDER BY Jobdate, TechnicianName, Street, Total) AS Rn
			 FROM dbo.Jobs_ExcelData) x
		WHERE x.rn > 1

	--No services performed
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NoServicesError 
		FROM dbo.Jobs_ExcelData
		WHERE (Carpet = '' OR Carpet IS NULL OR Carpet = 0)
			AND (UrineTreatment = '' OR UrineTreatment IS NULL OR UrineTreatment = 0)
			AND (Protectant = '' OR Protectant IS NULL OR Protectant = 0)
			AND (Upholstery = '' OR Upholstery IS NULL OR Upholstery = 0)
			AND (AirDucts = '' OR AirDucts IS NULL OR AirDucts = 0)
			AND (Tile = '' OR Tile IS NULL OR Tile = 0)
			AND (DryerVent = '' OR DryerVent IS NULL OR DryerVent = 0)
			AND (Other = '' OR Other IS NULL OR Other = 0)
			
	--Total does not match
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @TotalNotMatchError 
		FROM dbo.Jobs_ExcelData
		WHERE Total != (
			ISNULL(Carpet, 0) +
			ISNULL(UrineTreatment, 0) +
			ISNULL(Protectant, 0) +
			ISNULL(Upholstery, 0) +
			ISNULL(Airducts, 0) +
			ISNULL(Tile, 0) +
			ISNULL(Dryervent, 0) +
			ISNULL(Other, 0) -
			ISNULL(Discount, 0))
			
	--Cannot find technician in table
	INSERT INTO dbo.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NotValidTechnician 
		FROM dbo.Jobs_ExcelData e
		LEFT JOIN DBO.Technicians t ON t.Name = e.TechnicianName
		WHERE t.TechnicianID IS NULL
		
	--Cannot find City in table
	INSERT INTO DBO.ExcelDataErrors	(ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NotvalidCity 
		FROM dbo.Jobs_ExcelData e
		LEFT JOIN DBO.Cities c ON c.City = e.city
		WHERE c.CityID IS NULL

	--City not in Missouri OR Illinois
	INSERT INTO DBO.ExcelDataErrors (ExcelDataRowId, ErrorMessage)
		SELECT RowId, @NotValidState 
		FROM dbo.Jobs_ExcelData e
		WHERE [STATE] NOT IN ('MO','IL')

	--Zip code wrong
	INSERT INTO DBO.ExcelDataErrors (ExcelDataRowId, ErrorMessage)
		SELECT RowId, @WrongZipcode 
		FROM dbo.Jobs_ExcelData e
		WHERE Zipcode NOT LIKE '[6][0-9][0-9][0-9][0-9]'

	--Passed Validation
	UPDATE e
		SET LoadDataNotes = @PassedValidation
		FROM dbo.Jobs_ExcelData e
		LEFT JOIN DBO.ExcelDataErrors edt ON edt.ExcelDataRowId = e.RowId
		WHERE edt.ErrorId IS NULL

	--Failed Validation
	UPDATE e
		SET Loaddatanotes = @FailedValidation
		FROM dbo.Jobs_ExcelData e
		JOIN dbo.ExcelDataErrors edt ON edt.ExcelDataRowId = e.RowId

END
GO
/****** Object:  StoredProcedure [dbo].[ResetStage]    Script Date: 12/22/2022 7:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResetStage]
AS
BEGIN
	
	SET NOCOUNT ON;

    DELETE FROM ExcelDataErrors
	DELETE FROM Jobs_ExcelData
	DELETE FROM Addresses
	DELETE FROM JobDetails
	DELETE FROM Jobs
END
GO
USE [master]
GO
ALTER DATABASE [CarpetCleaning] SET  READ_WRITE 
GO

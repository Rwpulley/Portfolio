USE [CarpetCleaning]
GO

/****** Object:  Table [dbo].[Jobs_ExcelData]    Script Date: 12/19/2022 2:42:37 PM ******/
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

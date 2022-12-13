CREATE TABLE [dbo].[Exceldata](
	[JobDate] [date] NULL,
	[TechnicianName] [char](15) NULL,
	[AddressNumber] [int] NULL,
	[Street] [varchar](30) NULL,
	[Apartment] [varchar](6) NULL,
	[City] [varchar](30) NULL,
	[State] [char](2) NULL,
	[Zip] [int] NULL,
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
	[LoadData] [varchar](255) NULL
) ON [PRIMARY]
GO
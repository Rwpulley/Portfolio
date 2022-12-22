USE [CarpetCleaning]
GO

/****** Object:  Table [dbo].[Addresses]    Script Date: 12/19/2022 2:40:28 PM ******/
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

ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK__Addresses__CityI__534D60F1] FOREIGN KEY([CityID])
REFERENCES [dbo].[Cities] ([CityID])
GO

ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK__Addresses__CityI__534D60F1]
GO

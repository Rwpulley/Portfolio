USE [CarpetCleaning]
GO

/****** Object:  Table [dbo].[Cities]    Script Date: 12/19/2022 2:41:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cities](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[City] [varchar](30) NOT NULL,
	[MilesFromAreaCenter] [decimal](18, 2) NULL,
 CONSTRAINT [PK__City__F2D21A96E67703C7] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

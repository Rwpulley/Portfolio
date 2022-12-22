USE [CarpetCleaning]
GO

/****** Object:  Table [dbo].[ServiceTypes]    Script Date: 12/19/2022 2:45:15 PM ******/
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

ALTER TABLE [dbo].[ServiceTypes]  WITH CHECK ADD FOREIGN KEY([ServiceTypeCategoryID])
REFERENCES [dbo].[ServiceTypeCategories] ([ServiceTypeCategoryID])
GO

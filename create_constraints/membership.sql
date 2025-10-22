USE [Body_BluePrint_fitness center]
GO

/****** Object:  Table [dbo].[membership_types]    Script Date: 01/12/2024 11:52:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[membership_types](
	[membership_type_id] [int] IDENTITY(1,1) NOT NULL,
	[mem_type_name] [varchar](50) NOT NULL,
	[duration_months] [int] NOT NULL,
	[monthly_fee] [decimal](10, 2) NOT NULL,
	[mem_description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[membership_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO



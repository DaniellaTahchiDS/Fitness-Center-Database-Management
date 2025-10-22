USE [Body_BluePrint_Center]
GO

/****** Object:  Table [dbo].[equipment]    Script Date: 01/12/2024 11:51:37 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[equipment](
	[equipment_id] [int] IDENTITY(1,1) NOT NULL,
	[equipment_name] [varchar](100) NOT NULL,
	[eq_description] [text] NULL,
	[purchase_date] [date] NULL,
	[last_maintenance_date] [date] NULL,
	[eq_status] [varchar](20) NULL,
	[cost] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[equipment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[equipment]  WITH CHECK ADD CHECK  (([eq_status]='Out of Order' OR [eq_status]='Under Maintenance' OR [eq_status]='In Use' OR [eq_status]='Available'))
GO



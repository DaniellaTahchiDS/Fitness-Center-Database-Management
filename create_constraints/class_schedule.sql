USE [Body_BluePrint_Center]
GO

/****** Object:  Table [dbo].[class_schedule]    Script Date: 01/12/2024 11:53:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[class_schedule](
	[schedule_id] [int] IDENTITY(1,1) NOT NULL,
	[class_id] [int] NULL,
	[start_time] [time](7) NOT NULL,
	[room_number] [varchar](10) NULL,
	[remaining_capacity] [int] NULL,
	[class_days] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[class_schedule]  WITH CHECK ADD FOREIGN KEY([class_id])
REFERENCES [dbo].[classes] ([class_id])
GO



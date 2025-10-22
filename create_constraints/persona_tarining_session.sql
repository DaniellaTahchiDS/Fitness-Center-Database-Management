USE [Body_BluePrint_Center]
GO

/****** Object:  Table [dbo].[personal_training_sessions]    Script Date: 01/12/2024 12:00:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[personal_training_sessions](
	[per_session_id] [int] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NULL,
	[trainer_id] [int] NULL,
	[session_date] [date] NOT NULL,
	[start_time] [time](7) NOT NULL,
	[end_time] [time](7) NOT NULL,
	[session_status] [varchar](20) NULL,
	[notes] [text] NULL,
	[rating] [int] NULL,
	[feedback] [text] NULL,
	[fee] [decimal](10, 2) NULL,
	[room] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[per_session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[personal_training_sessions]  WITH CHECK ADD FOREIGN KEY([member_id])
REFERENCES [dbo].[members] ([member_id])
GO

ALTER TABLE [dbo].[personal_training_sessions]  WITH CHECK ADD FOREIGN KEY([trainer_id])
REFERENCES [dbo].[trainers] ([trainer_id])
GO

ALTER TABLE [dbo].[personal_training_sessions]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO

ALTER TABLE [dbo].[personal_training_sessions]  WITH CHECK ADD CHECK  (([session_status]='No-Show' OR [session_status]='Cancelled' OR [session_status]='Completed' OR [session_status]='Scheduled'))
GO



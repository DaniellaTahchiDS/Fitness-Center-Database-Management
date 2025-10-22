USE [Body_BluePrint_Center]
GO

/****** Object:  Table [dbo].[classes]    Script Date: 01/12/2024 11:52:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[classes](
	[class_id] [int] IDENTITY(1,1) NOT NULL,
	[class_name] [varchar](100) NOT NULL,
	[cl_description] [text] NULL,
	[capacity] [int] NOT NULL,
	[duration_hrs] [int] NOT NULL,
	[trainer_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[class_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[classes]  WITH CHECK ADD FOREIGN KEY([trainer_id])
REFERENCES [dbo].[trainers] ([trainer_id])
GO



USE [Body_BluePrint_Center]
GO

/****** Object:  Table [dbo].[class_bookings]    Script Date: 01/12/2024 11:55:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[class_bookings](
	[booking_id] [int] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NULL,
	[schedule_id] [int] NULL,
	[booking_date] [date] NULL,
	[attendance_status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[class_bookings] ADD  DEFAULT ('Booked') FOR [attendance_status]
GO

ALTER TABLE [dbo].[class_bookings]  WITH CHECK ADD FOREIGN KEY([member_id])
REFERENCES [dbo].[members] ([member_id])
GO

ALTER TABLE [dbo].[class_bookings]  WITH CHECK ADD FOREIGN KEY([schedule_id])
REFERENCES [dbo].[class_schedule] ([schedule_id])
GO

ALTER TABLE [dbo].[class_bookings]  WITH CHECK ADD CHECK  ((datepart(day,[booking_date])>=(25) AND datepart(day,[booking_date])<=(31)))
GO



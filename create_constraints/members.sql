USE [Body_BluePrint_Center]
GO

/****** Object:  Table [dbo].[members]    Script Date: 01/12/2024 11:49:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[members](
	[member_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone] [varchar](15) NULL,
	[date_of_birth] [date] NULL,
	[join_date] [date] NULL,
	[membership_status] [varchar](20) NULL,
	[membership_type_id] [int] NULL,
	[employee] [int]  NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[member_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[members] ADD  DEFAULT (getdate()) FOR [join_date]
GO

ALTER TABLE [dbo].[members]  WITH CHECK ADD FOREIGN KEY([membership_type_id])
REFERENCES [dbo].[membership_types] ([membership_type_id])
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD FOREIGN KEY([employee])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD CHECK  (([membership_status]='Suspended' OR [membership_status]='Inactive' OR [membership_status]='Active'))
GO



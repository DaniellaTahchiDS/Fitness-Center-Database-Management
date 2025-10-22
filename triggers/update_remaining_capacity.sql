USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[update_remaining_capacity]    Script Date: 01/12/2024 11:58:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[update_remaining_capacity]
ON [dbo].[class_bookings]
AFTER INSERT
AS
BEGIN
	
    UPDATE class_schedule
    SET remaining_capacity = remaining_capacity - 1
    WHERE class_id = (SELECT class_id FROM inserted)
	

END;
GO

ALTER TABLE [dbo].[class_bookings] ENABLE TRIGGER [update_remaining_capacity]
GO



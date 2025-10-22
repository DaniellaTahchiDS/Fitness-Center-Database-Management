USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[schedule_time_before_2]    Script Date: 01/12/2024 11:54:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[schedule_time_before_2]
ON [dbo].[class_schedule]
AFTER INSERT
AS
BEGIN
	DECLARE @start_time TIME;
	SElect @start_time = start_time FROM inserted;
	IF (DATEPART(HOUR,@start_time)>14)
	BEGIN
		RAISERROR ('Class time should be before 2 pm',16,1)
		ROLLBACK TRANSACTION
	END
	
END;

GO

ALTER TABLE [dbo].[class_schedule] ENABLE TRIGGER [schedule_time_before_2]
GO



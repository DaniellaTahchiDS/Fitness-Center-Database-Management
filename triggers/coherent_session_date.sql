USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[coherent_start_end_times]    Script Date: 01/12/2024 12:02:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[coherent_start_end_times]
ON [dbo].[personal_training_sessions]
AFTER INSERT
AS
BEGIN
	DECLARE @start TIME, @end TIME, @sessiondate DATE, @member INT, @trainer INT, @joindate DATE, @hiredate DATE;
	SELECT @start = start_time From inserted;
	SELECT @end = end_time From inserted;
	SELECT @sessiondate = session_date FROM inserted;
	SELECT @member = member_id FROM inserted;
	SELECT @trainer = trainer_id FROM inserted;
	SELECT @joindate = join_date FROM members WHERE member_id= @member;
	SELECT @hiredate = hire_date FROM trainers WHERE trainer_id = @trainer;

	IF ((DATEPART(HOUR,@start))> (DATEPART(HOUR,@end)) or (DATEPART(HOUR,@start)<16))
	BEGIN
		RAISERROR ('Make sure the start time is after 4pm and before the end time',16,1)
		ROLLBACK TRANSACTION
	END
	IF (@joindate>@sessiondate or @hiredate>@sessiondate)
	BEGIN
		RAISERROR ('Make sure the session date is after member join date or trainer hire date',16,1)
		ROLLBACK TRANSACTION
	END
END;
GO

ALTER TABLE [dbo].[personal_training_sessions] ENABLE TRIGGER [coherent_start_end_times]
GO



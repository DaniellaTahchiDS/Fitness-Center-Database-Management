USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[membership_management]    Script Date: 01/12/2024 11:50:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [dbo].[membership_management]
ON [dbo].[members]
AFTER INSERT
AS
BEGIN
	DECLARE @memship INT, @dob DATE;
	SELECT @memship = membership_type_id FROM inserted;
	SELECT @dob = date_of_birth FROM inserted;
	IF(@memship=3 and (DATEPART(YEAR, GETDATE())-DATEPART(YEAR,@dob)>30))
	BEGIN
		RAISERROR('This member can not benefit from student plan.',16,1)
		ROLLBACK TRANSACTION
	END
	IF (@memship=4 and (DATEPART(YEAR, GETDATE())-DATEPART(YEAR,@dob)<57))
	BEGIN
		RAISERROR ('This member can not benefit from senior plan.',16,1)
		ROLLBACK TRANSACTION
	END
	
END;



GO

ALTER TABLE [dbo].[members] ENABLE TRIGGER [membership_management]
GO



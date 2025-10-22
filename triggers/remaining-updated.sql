USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[set_default_remaining_capacity]    Script Date: 01/12/2024 11:10:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[set_default_remaining_capacity]
ON [dbo].[class_schedule]
AFTER INSERT
AS
BEGIN
    DECLARE @class_id INT;
    DECLARE @capacity INT;
	DECLARE @room VARCHAR(20);
	DECLARE @days VARCHAR(50);
    -- Get the class_id from the inserted row
    SELECT @class_id = class_id FROM inserted;
	SELECT @room = room_number FROM inserted;
	SELECT @days = class_days FROM inserted;
    -- Get the capacity from the classes table
    SELECT @capacity = capacity
    FROM classes
    WHERE class_id = @class_id;

    -- Insert the new row with the default remaining_capacity
    
	UPDATE class_schedule
	SET remaining_capacity=@capacity
	WHERE class_id=@class_id and room_number=@room and class_days=@days ;
END;
GO



USE [Body_BluePrint_fitness center]
GO

/****** Object:  Trigger [dbo].[set_default_remaining_capacity]    Script Date: 01/12/2024 11:55:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[set_default_remaining_capacity]
ON [dbo].[class_schedule]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @class_id INT;
    DECLARE @capacity INT;

    -- Get the class_id from the inserted row
    SELECT @class_id = class_id FROM inserted;

    -- Get the capacity from the classes table
    SELECT @capacity = capacity
    FROM classes
    WHERE class_id = @class_id;

    -- Insert the new row with the default remaining_capacity
    INSERT INTO class_schedule (class_id, start_time, room_number, remaining_capacity, class_days)
    SELECT class_id, start_time, room_number, ISNULL(remaining_capacity, @capacity), class_days
    FROM inserted;
END;
GO

ALTER TABLE [dbo].[class_schedule] ENABLE TRIGGER [set_default_remaining_capacity]
GO



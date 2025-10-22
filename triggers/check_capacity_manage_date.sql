USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[check_class_capacity_manage_date]    Script Date: 01/12/2024 11:56:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE TRIGGER [dbo].[check_class_capacity_manage_date]
ON [dbo].[class_bookings]
AFTER INSERT
AS
BEGIN
    DECLARE @class_capacity INT;
    DECLARE @current_bookings INT;
    DECLARE @schedule_id INT;
	DECLARE @bookdate DATE, @member INT,@join DATE,@hiredate DATE, @class INT;
	
	SELECT @schedule_id = schedule_id FROM inserted;
	SELECT @bookdate= booking_date FROM inserted;
	SELECT @member = member_id FROM inserted;
	SELECT @class= class_id FROM class_schedule WHERE schedule_id=@schedule_id; 
	SELECT @join = join_date FROM members WHERE member_id=@member;
	SELECT @hiredate = hire_date FROM trainers WHERE trainer_id=(SELECT trainer_id FROM classes WHERE class_id=@class);
    -- Get the schedule_id from the inserted row
    

    -- Get the capacity of the class
    SELECT @class_capacity = capacity
    FROM classes
    WHERE(class_id=(SELECT class_id From class_schedule Where schedule_id = @schedule_id));

    -- Get the current number of bookings for the class
    SELECT @current_bookings = COUNT(*)
    FROM class_bookings
    WHERE schedule_id = @schedule_id;

    -- Check if the class is already full
    IF @current_bookings >= @class_capacity
    BEGIN
        RAISERROR('Class is already full', 16, 1);
        ROLLBACK TRANSACTION;
    END
	IF (@join>@bookdate or @hiredate>@bookdate)
	BEGIN
		RAISERROR('The booking date should be after the member join date or the trainer hire date',16,1)
		ROLLBACK TRANSACTION
	END
    
END;
GO

ALTER TABLE [dbo].[class_bookings] ENABLE TRIGGER [check_class_capacity_manage_date]
GO



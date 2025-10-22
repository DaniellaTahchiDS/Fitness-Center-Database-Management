USE [Body_BluePrint_Center]
GO

/****** Object:  Trigger [dbo].[CalculateSessionFee]    Script Date: 01/12/2024 12:01:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[CalculateSessionFee]
ON [dbo].[personal_training_sessions]
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @SessionId INT, @TrainerId INT, @StartTime TIME, @EndTime TIME, @Duration INT, @HourlyRate DECIMAL(10,2);

    SELECT @SessionId = per_session_id, @TrainerId = trainer_id, @StartTime = start_time, @EndTime = end_time
    FROM inserted ;

    SELECT @HourlyRate = hourly_rate
    FROM Trainers
    WHERE trainer_id = @TrainerId;

    -- Calculate duration in minutes
    SET @Duration = DATEDIFF(minute, @StartTime, @EndTime);

    -- Calculate fee based on duration and hourly rate
    UPDATE [dbo].[personal_training_sessions]
    SET fee = ((@Duration / 60.0) * @HourlyRate)*1.25
    WHERE per_session_id = @SessionId;
END;
GO

ALTER TABLE [dbo].[personal_training_sessions] ENABLE TRIGGER [CalculateSessionFee]
GO



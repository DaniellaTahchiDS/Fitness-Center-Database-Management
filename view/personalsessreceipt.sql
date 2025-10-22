USE [Body_BluePrint_Center]
GO

CREATE VIEW [dbo].[vw_PersonalTrainingReceipt]
AS
SELECT 
    pts.per_session_id AS 'Session ID',
    m.first_name + ' ' + m.last_name AS 'Member Name',
    t.first_name + ' ' + t.last_name AS 'Trainer Name',
    CONVERT(VARCHAR(10), pts.session_date, 101) AS 'Session Date',
    CONVERT(VARCHAR(5), pts.start_time, 108) + ' - ' + CONVERT(VARCHAR(5), pts.end_time, 108) AS 'Session Time',
    pts.room AS 'Room',
    pts.fee AS 'Session Fee'
FROM 
    [dbo].[personal_training_sessions] pts
JOIN 
    [dbo].[members] m ON pts.member_id = m.member_id
JOIN 
    [dbo].[trainers] t ON pts.trainer_id = t.trainer_id
WHERE 
    pts.session_status = 'Completed';
GO
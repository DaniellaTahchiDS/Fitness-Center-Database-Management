USE [Body_BluePrint_Center]
GO

CREATE VIEW [dbo].[vw_ClassAttendanceCompleteSummary]
AS
SELECT 
    c.class_name AS 'Class Name',
    cs.class_days AS 'Class Days',
    CONVERT(VARCHAR(5), cs.start_time, 108) AS 'Start Time',
    COUNT( cb.booking_id) AS 'Total_Bookings',
	SUM(CASE WHEN cb.attendance_status = 'Completed' THEN 1 ELSE 0 END) AS 'Completed'
	
FROM 
    [dbo].[classes] c
JOIN 
    [dbo].[class_schedule] cs ON c.class_id = cs.class_id
LEFT JOIN 
    [dbo].[schedule_by_month] sbm ON cs.schedule_id = sbm.schedule_id
LEFT JOIN 
    [dbo].[class_bookings] cb ON sbm.schedule_month_id = cb.schedule_month_id 
GROUP BY 
    c.class_name, cs.class_days, cs.start_time;
GO
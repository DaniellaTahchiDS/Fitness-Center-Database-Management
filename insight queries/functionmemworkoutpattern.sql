CREATE OR ALTER FUNCTION fn_GetMemberAttendancePatterns
(
    @monthsBack int = 2
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        m.member_id,
        m.first_name + ' ' + m.last_name as member_name,
        c.class_name,
        cs.class_days,
        cs.start_time,
        COUNT(*) as attendance_count,
        STRING_AGG(CONVERT(varchar, cb.booking_date, 23), ', ') as booking_dates
    FROM members m
    JOIN class_bookings cb ON m.member_id = cb.member_id
    JOIN schedule_by_month sbm ON cb.schedule_month_id = sbm.schedule_month_id
    JOIN class_schedule cs ON sbm.schedule_id = cs.schedule_id
    JOIN classes c ON cs.class_id = c.class_id
    WHERE cb.booking_date >= DATEADD(month, -@monthsBack, GETDATE())
    GROUP BY 
        m.member_id,
        m.first_name + ' ' + m.last_name,
        c.class_name,
        cs.class_days,
        cs.start_time
);

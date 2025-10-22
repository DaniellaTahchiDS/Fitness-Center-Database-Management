WITH MemberActivity AS (
    SELECT 
        m.member_id,
        m.first_name + ' ' + m.last_name as member_name,
        m.join_date,
        COUNT(DISTINCT cb.booking_id) as class_bookings,
        COUNT(DISTINCT pts.per_session_id) as personal_sessions,
        MAX(CASE 
            WHEN cb.booking_date IS NOT NULL THEN cb.booking_date
            WHEN pts.session_date IS NOT NULL THEN pts.session_date
        END) as last_activity_date
    FROM members m
    LEFT JOIN class_bookings cb ON m.member_id = cb.member_id
    LEFT JOIN personal_training_sessions pts ON m.member_id = pts.member_id
    GROUP BY m.member_id, m.first_name, m.last_name, m.join_date
)
SELECT 
	member_id,
    member_name,
    DATEDIFF(month, join_date, GETDATE()) as months_as_member,
    class_bookings,
    personal_sessions,
    DATEDIFF(day, last_activity_date, GETDATE()) as days_since_last_activity,
    CASE 
        WHEN DATEDIFF(day, last_activity_date, GETDATE()) > 40 OR DATEDIFF(day, last_activity_date, GETDATE()) IS NULL THEN 'At Risk'
        WHEN DATEDIFF(day, last_activity_date, GETDATE()) > 15 THEN 'Needs Attention'
        ELSE 'Active'
    END as member_status
FROM MemberActivity
ORDER BY member_status, days_since_last_activity ;
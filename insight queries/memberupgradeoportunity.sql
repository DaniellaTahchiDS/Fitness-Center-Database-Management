WITH MemberServices AS (
    SELECT 
        m.member_id,
        m.first_name + ' ' + m.last_name as member_name,
        mt.mem_type_name,
        COUNT(DISTINCT cb.booking_id) as class_bookings,
        COUNT(DISTINCT pts.per_session_id) as personal_training_sessions,
        AVG(pts.rating) as avg_training_rating,
        SUM(pts.fee) as total_training_fees
    FROM members m
    LEFT JOIN membership_types mt ON m.membership_type_id = mt.membership_type_id
    LEFT JOIN class_bookings cb ON m.member_id = cb.member_id
    LEFT JOIN personal_training_sessions pts ON m.member_id = pts.member_id
    GROUP BY m.member_id, m.first_name, m.last_name, mt.mem_type_name
)
SELECT 
    member_name,
    mem_type_name,
    class_bookings,
    personal_training_sessions,
    avg_training_rating,
    total_training_fees,
    CASE 
        WHEN personal_training_sessions = 0 AND class_bookings > 5 THEN 'PT Prospect'
        WHEN personal_training_sessions > 0 AND avg_training_rating >= 4 THEN 'PT Upsell Opportunity'
        WHEN class_bookings = 0 AND personal_training_sessions > 0 THEN 'Class Prospect'
        WHEN mem_type_name NOT LIKE '%Premium%' AND (class_bookings > 8 OR personal_training_sessions > 4) THEN 'Membership Upgrade Prospect'
        ELSE 'Regular Member'
    END as opportunity_category
FROM MemberServices
ORDER BY total_training_fees DESC;
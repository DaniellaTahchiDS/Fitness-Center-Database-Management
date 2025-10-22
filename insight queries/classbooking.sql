SELECT
    c.class_name,
    c.capacity AS max_capacity,
    COUNT(cb.booking_id) AS total_bookings,
    COUNT(DISTINCT cb.member_id) AS unique_members,
    t.first_name + ' ' + t.last_name AS trainer_name,
	dbo.GetClassOpenCount(c.class_id) AS TimesOpened,
    
    -- Bookings by recent periods
    COUNT(CASE 
        WHEN schm.schedule_month = 11
        THEN cb.booking_id 
    END) AS last_month_bookings,
    -- Average bookings per schedule
    ROUND(
        CAST(COUNT(cb.booking_id) AS FLOAT) / 
        NULLIF(dbo.GetClassOpenCount(c.class_id), 0),
        2
    ) AS avg_bookings_per_schedule
FROM 
    classes AS c
LEFT JOIN 
    trainers AS t 
    ON c.trainer_id = t.trainer_id
LEFT JOIN
    class_schedule AS sch 
    ON c.class_id = sch.class_id
LEFT JOIN
    schedule_by_month AS schm 
    ON sch.schedule_id = schm.schedule_id
LEFT JOIN
    class_bookings AS cb 
    ON schm.schedule_month_id = cb.schedule_month_id
GROUP BY 
	c.class_id,
    c.class_name, 
    c.capacity,
    t.first_name + ' ' + t.last_name
HAVING 
    COUNT(cb.booking_id) > 0
ORDER BY 
    total_bookings DESC;

WITH TimeSlots AS (
    SELECT 
        cs.start_time,
        c.class_name,
        c.capacity,
        cs.room_number,
        cs.class_days,
        COUNT(cb.booking_id) AS total_bookings,
        DATEPART(HOUR, cs.start_time) AS hour_of_day
    FROM 
        class_schedule cs
    JOIN 
        classes c ON cs.class_id = c.class_id
    JOIN 
        schedule_by_month sbm ON cs.schedule_id = sbm.schedule_id
    LEFT JOIN 
        class_bookings cb ON sbm.schedule_month_id = cb.schedule_month_id
    GROUP BY 
        cs.start_time, c.class_name, c.capacity, cs.room_number, cs.class_days
)
SELECT 
    hour_of_day,
    COUNT(DISTINCT class_name) AS number_of_classes,
    SUM(total_bookings) AS total_bookings,
    SUM(capacity) AS total_capacity,
	COUNT(DISTINCT class_days) as available_schedule_days
    
FROM 
    TimeSlots 
GROUP BY 
    hour_of_day
ORDER BY 
    hour_of_day ;

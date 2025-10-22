WITH TrainerSchedule AS (
    SELECT 
        t.trainer_id,
        t.first_name + ' ' + t.last_name as trainer_name,
        DATEPART(weekday, pts.session_date) as day_of_week,
        DATEPART(hour, pts.start_time) as hour_of_day,
        COUNT(*) as sessions_booked,
        SUM(pts.fee) as tot_session_fee
    FROM trainers t
    LEFT JOIN personal_training_sessions pts ON t.trainer_id = pts.trainer_id
    WHERE pts.session_date >= '2024-12-01'
    GROUP BY t.trainer_id, t.first_name, t.last_name, 
             DATEPART(weekday, pts.session_date), 
             DATEPART(hour, pts.start_time)
)
SELECT 
    trainer_name,
    CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END as weekday,
    hour_of_day,
    sessions_booked,
    tot_session_fee
FROM TrainerSchedule
ORDER BY trainer_id, day_of_week, hour_of_day;
SELECT 
    t.trainer_id,
    t.first_name + ' ' + t.last_name as trainer_name,
	t.specialization,
    COUNT(pts.per_session_id) as total_sessions,
    COUNT(CASE WHEN pts.session_status = 'Completed' THEN 1 END) as completed_sessions,
    CAST(AVG(pts.rating) as DECIMAL(10,2)) as avg_rating,
    SUM(pts.fee) as total_revenue
    
FROM trainers t
LEFT JOIN personal_training_sessions pts ON t.trainer_id = pts.trainer_id
WHERE pts.session_date >= DATEADD(month, -3, GETDATE())
GROUP BY t.trainer_id, t.first_name, t.last_name, t.specialization
HAVING COUNT(pts.per_session_id) > 0
ORDER BY total_revenue DESC;
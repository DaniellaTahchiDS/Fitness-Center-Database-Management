SELECT
    e.equipment_name,
    e.eq_status,
    e.purchase_date,
    e.last_maintenance_date,
    DATEDIFF(DAY, e.last_maintenance_date, CURRENT_TIMESTAMP) AS days_since_maintenance,  -- Calculate days since last maintenance
    
    CASE 
        WHEN DATEDIFF(MONTH, e.last_maintenance_date, CURRENT_TIMESTAMP) > 6 THEN 'Overdue'
        WHEN DATEDIFF(MONTH, e.last_maintenance_date, CURRENT_TIMESTAMP) BETWEEN 5 AND 6 THEN 'Due Soon'
        ELSE 'Maintained'
    END AS maintenance_status  -- Maintenance status categorization
FROM 
    equipment e
WHERE 
    e.eq_status <> 'Under Maintenance'  -- Filter out retired equipment
ORDER BY 
    days_since_maintenance DESC;  -- Order by days since last maintenance
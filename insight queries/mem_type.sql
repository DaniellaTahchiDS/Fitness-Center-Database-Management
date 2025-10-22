WITH MembershipRevenue AS (
    SELECT 
        mt.mem_type_name,
        COUNT(m.member_id) as member_count,
        SUM(mt.monthly_fee * mt.duration_months) as total_revenue
    FROM members m
    JOIN membership_types mt ON m.membership_type_id = mt.membership_type_id
    GROUP BY mt.mem_type_name
)
SELECT 
    mem_type_name,
    member_count,
    total_revenue,
    CAST(ROUND((member_count * 100.0 / SUM(member_count) OVER()), 2) AS DECIMAL(10, 2)) AS membership_percentage
FROM MembershipRevenue
ORDER BY member_count DESC, total_revenue DESC;
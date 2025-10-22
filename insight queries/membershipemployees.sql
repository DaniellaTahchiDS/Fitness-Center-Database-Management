WITH MemberSignups AS (
    SELECT 
        e.employee_id,
        COUNT(m.member_id) as members_signed,
        SUM(mt.monthly_fee * mt.duration_months) as revenue_generated
    FROM employees e
    LEFT JOIN members m ON e.employee_id = m.employee
    LEFT JOIN membership_types mt ON m.membership_type_id = mt.membership_type_id
    
    GROUP BY e.employee_id,e.department
	
)
SELECT 
    e.first_name + ' ' + e.last_name as employee_name,
    e.position,
    e.department,
    e.shift_preference,
	DATEDIFF(month, e.hire_date, GETDATE()) as months_employed,
    ms.members_signed,
    ms.revenue_generated,
    e.salary,
    ROUND((ms.revenue_generated / e.salary), 2) as revenue_to_salary_ratio
FROM employees e
LEFT JOIN MemberSignups ms ON e.employee_id = ms.employee_id
WHERE e.emp_status = 'Active' and e.department='Sales'
ORDER BY revenue_generated DESC;
WITH Revenue AS (
    SELECT 
        SUM(mt.monthly_fee * mt.duration_months) AS total_membership_revenue,
        (SELECT SUM(p.fee/1.25) 
         FROM dbo.personal_training_sessions p 
         WHERE p.session_status = 'Completed') AS total_training_revenue
    FROM 
        dbo.members m
    JOIN 
        dbo.membership_types mt ON m.membership_type_id = mt.membership_type_id
),

TrainerCosts AS (
    SELECT 
        SUM(t.hourly_rate * 8) AS total_trainer_expenses 
    FROM 
        dbo.trainers t
),

EmployeeCosts AS (
    SELECT 
        SUM(e.salary) AS total_employee_expenses
    FROM 
        dbo.employees e
)
SELECT 
    r.total_membership_revenue + r.total_training_revenue AS total_revenue,
    tc.total_trainer_expenses + emc.total_employee_expenses AS total_expenses,
    (r.total_membership_revenue + r.total_training_revenue - 
     (tc.total_trainer_expenses + emc.total_employee_expenses)) AS total_profit
FROM 
    Revenue r, 
    TrainerCosts tc,  
    EmployeeCosts emc;
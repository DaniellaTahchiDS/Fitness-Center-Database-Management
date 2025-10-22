-- Create the employees table
CREATE TABLE employees (
    employee_id INT IDENTITY (1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    position VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    shift_preference VARCHAR(20),
    emp_status VARCHAR(20) DEFAULT 'Active',
    
);

INSERT INTO employees ( 
    first_name, 
    last_name, 
    email, 
    phone, 
    position, 
    department, 
    hire_date, 
    salary, 
    shift_preference, 
    emp_status
) VALUES
-- Management
('Sarah', 'Johnson', 'sarah.j@fitnesscenter.com', '55501011', 'General Manager', 'Management', '2024-01-15', 1500.00, 'Day', 'Active'),
('James', 'Martinez', 'james.m@fitnesscenter.com', '55501022', 'Operations Manager', 'Management', '2024-01-20', 1000.00, 'Day', 'Active'),

-- Front Desk Staff
('Emily', 'Wilson', 'emily.w@fitnesscenter.com', '55501033', 'Front Desk Lead', 'Front Desk', '2024-02-01', 700.00, 'Morning', 'Active'),
('Michael', 'Brown', 'michael.b@fitnesscenter.com', '55501044', 'Front Desk Associate', 'Front Desk', '2024-02-10', 500.00, 'Evening', 'Active'),
('Jessica', 'Taylor', 'jessica.t@fitnesscenter.com', '55501055', 'Front Desk Associate', 'Front Desk', '2024-02-15', 500.00, 'Morning', 'Active'),
('Daniel', 'Lee', 'daniel.l@fitnesscenter.com', '55501066', 'Front Desk Associate', 'Front Desk', '2024-02-20', 500.00, 'Night', 'Active'),

-- Maintenance Staff
('Robert', 'Garcia', 'robert.g@fitnesscenter.com', '55501077', 'Maintenance Supervisor', 'Maintenance', '2024-03-01', 650.00, 'Day', 'Active'),
('Thomas', 'Anderson', 'thomas.a@fitnesscenter.com', '55501088', 'Maintenance Technician', 'Maintenance', '2024-03-10', 450.00, 'Evening', 'Active'),
('William', 'Wright', 'william.w@fitnesscenter.com', '55501099', 'Maintenance Technician', 'Maintenance', '2024-03-15', 450.00, 'Morning', 'Active'),

-- Housekeeping Staff
('Maria', 'Lopez', 'maria.l@fitnesscenter.com', '55502011', 'Housekeeping Supervisor', 'Housekeeping', '2024-04-01', 450.00, 'Day', 'Active'),
('Ana', 'Santos', 'ana.s@fitnesscenter.com', '55502022', 'Housekeeper', 'Housekeeping', '2024-04-10', 400.00, 'Morning', 'Active'),
('David', 'Kim', 'david.k@fitnesscenter.com', '55502033', 'Housekeeper', 'Housekeeping', '2024-04-15', 400.00, 'Evening', 'Active'),
-- Membership Consultants
('Lisa', 'Chen', 'lisa.c@fitnesscenter.com', '555-0125', 'Membership Director', 'Sales', '2023-01-20', 500.00, 'Day', 'Active'),
('Kevin', 'Patel', 'kevin.p@fitnesscenter.com', '555-0127', 'Membership Consultant', 'Sales', '2023-02-15', 450.00, 'Morning', 'Active'),
('Rachel', 'Green', 'rachel.g@fitnesscenter.com', '555-0129', 'Membership Consultant', 'Sales', '2023-03-01', 450.00, 'Evening','Active')

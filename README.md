# Body Blueprint Fitness Center Database Management System

A comprehensive database solution designed to streamline operations and enhance decision-making for a modern fitness center.

## 📋 Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Database Schema](#database-schema)
- [Business Rules](#business-rules)
- [Installation](#installation)
- [Usage](#usage)
- [Queries & Analytics](#queries--analytics)
- [Sample Data](#sample-data)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

The Body Blueprint Fitness Center Database Management System centralizes operations across memberships, trainers, equipment, employees, and class scheduling. This system enables efficient tracking of financial performance, member engagement, and resource allocation through automated business logic and comprehensive analytics.

## ✨ Features

### Member Management
- 8 subscription plans with automated age-based assignments
- Student plan for members under 30
- Senior plan for members over 57
- Automatic join date tracking

### Class Operations
- 8 fitness classes included with all memberships
- Month-long classes with capacity management
- Classes offered 2 days per week before 2 PM
- Booking window: 25th-31st of preceding month
- Real-time capacity tracking

### Personal Training
- One-on-one sessions with 8 specialized trainers
- Sessions scheduled after 4 PM
- Automated fee calculation based on duration and hourly rate
- Rating system (1-5 stars)
- Session status tracking (Scheduled, Completed, Cancelled, No-show)

### Resource Management
- Equipment tracking with maintenance status
- Employee management across multiple departments
- Trainer specialization and performance tracking

## 🗄️ Database Schema

The system consists of 10 interconnected tables:

1. **members** - Member profiles and membership information
2. **membership_type** - Subscription plan details and pricing
3. **trainers** - Trainer profiles, specializations, and rates
4. **equipment** - Equipment inventory and maintenance tracking
5. **classes** - Class types, descriptions, and capacities
6. **class_schedule** - Weekly class schedules
7. **schedule_month** - Monthly class offerings and capacity
8. **class_booking** - Member class registrations
9. **personal_training_sessions** - One-on-one training bookings
10. **employees** - Staff records and positions

### Entity Relationship Diagram
Refer to the ERD diagram in the documentation for detailed relationships between tables.

## 📐 Business Rules

### Automated Triggers

**Member Management**
- Auto-assign student membership for members < 30 years
- Auto-assign senior membership for members > 57 years

**Class Scheduling**
- Enforce class times before 2 PM
- Set remaining capacity equal to class capacity on schedule creation
- Update remaining capacity on booking

**Class Booking**
- Validate booking date is between 25th-31st
- Ensure booking is one month before class schedule
- Check member join date and trainer hire date
- Verify class capacity availability
- Default attendance status to "Booked"

**Personal Training Sessions**
- Calculate fees automatically (duration × hourly rate)
- Enforce session times after 4 PM
- Validate start time is before end time
- Verify member and trainer eligibility dates

### Data Constraints

- Equipment status: Out of Order, Under Maintenance, In Use, Available
- Session ratings: 1-5 scale
- Session status: Scheduled, Completed, Cancelled, No-show
- Booking days: 25-31 only
- Default employee status: Active

## 🚀 Installation

### Prerequisites
- SQL Server or compatible RDBMS
- Database management tool (SQL Server Management Studio, Azure Data Studio, etc.)

### Setup Steps

1. Clone the repository
```bash
git clone https://github.com/yourusername/body-blueprint-db.git
cd body-blueprint-db
```

2. Create the database
```sql
CREATE DATABASE BodyBlueprintDB;
GO
USE BodyBlueprintDB;
GO
```

3. Execute the schema creation script
```sql
-- Run schema.sql to create all tables
```

4. Apply constraints and triggers
```sql
-- Run constraints_triggers.sql
```

5. Load sample data (optional)
```sql
-- Run sample_data.sql
```

## 💻 Usage

### Common Operations

**Register a New Member**
```sql
INSERT INTO members (first_name, last_name, email, phone, date_of_birth, membership_type_id)
VALUES ('John', 'Doe', 'john.doe@email.com', '123-456-7890', '1995-05-15', 1);
```

**Book a Class**
```sql
INSERT INTO class_booking (member_id, schedule_month_id, booking_date)
VALUES (1, 5, '2025-09-28');
```

**Schedule Personal Training**
```sql
INSERT INTO personal_training_sessions (member_id, trainer_id, session_date, start_time, duration_minutes)
VALUES (1, 3, '2025-10-15', '17:00', 60);
```

**Check Class Availability**
```sql
SELECT c.class_name, sm.remaining_capacity, sm.month_year
FROM schedule_month sm
JOIN class_schedule cs ON sm.schedule_id = cs.schedule_id
JOIN classes c ON cs.class_id = c.class_id
WHERE sm.remaining_capacity > 0 AND sm.month_year = '2025-10';
```

## 📊 Queries & Analytics

The system includes 13 comprehensive analytical queries:

1. **Revenue by Membership Type** - Track income across subscription plans
2. **Employee Performance** - Analyze sales staff effectiveness
3. **Member Engagement** - Monitor activity and participation rates
4. **Upsell Opportunities** - Identify members for personal training
5. **Workout Patterns** - Understand member behavior trends
6. **Trainer Performance** - Evaluate personal training metrics (last 3 months)
7. **Trainer Schedules** - View current month class assignments
8. **Equipment Maintenance** - Track maintenance needs and costs
9. **Class Popularity** - Rank classes by booking rates
10. **Booking Analysis** - Detailed class attendance metrics
11. **Profit Analysis** - Calculate overall financial performance
12. **Training Session Receipts** - Generate billing summaries (VIEW)
13. **Attendance Summary** - Track completed class participation (VIEW)

### Example: Revenue Analysis
```sql
SELECT mt.membership_name, 
       COUNT(m.member_id) as total_members,
       SUM(mt.price) as total_revenue
FROM members m
JOIN membership_type mt ON m.membership_type_id = mt.membership_type_id
GROUP BY mt.membership_name, mt.price
ORDER BY total_revenue DESC;
```

## 📈 Sample Data

The database includes sample data for testing:
- 8 membership types
- 40 members
- 8 trainers
- 20 equipment items
- 15 employees
- 8 classes
- 208 class bookings
- 168 personal training sessions

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow SQL naming conventions (snake_case for tables/columns)
- Document all triggers and constraints
- Test business rules thoroughly
- Update README for new features

## 👥 Authors

**Body Blueprint Development Team**
- Database Design & Implementation
- Business Logic Development
- Analytics & Reporting

## 🙏 Acknowledgments

- Fitness industry best practices
- Database design patterns
- SQL Server documentation

---

**Project Status**: Active Development
**Last Updated**: October 2025

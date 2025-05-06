# Week 8 Database Assignment

## Project Structure
- **Question 1**: Clinic Booking System Database Design
  - Complete MySQL database implementation
  - Patient and doctor management system
  - Appointment scheduling and tracking
  - Medication and prescription handling
  - Staff and user management
- **Question 2**: Task Manager REST API
  - Full CRUD operations
  - User authentication and authorization
  - Task management features
  - MySQL database integration

## Setup Instructions

### Prerequisites
- Node.js (v14 or higher)
- MySQL (v8.0 or higher)
- npm (Node Package Manager)
- Git

### Installation
1. Clone the repository:
```bash
git clone <your-repository-url>
cd "Week 8 Database assignment project"
```

2. Set up Question 1 - Clinic Booking System:
```bash
cd Question1_ClinicBooking
mysql -u root -p < schema.sql
mysql -u root -p < sample_data.sql
```

3. Set up Question 2 - Task Manager API:
```bash
cd ../Question2_TaskManagerAPI
npm install
```

4. Configure environment variables:
```bash
copy .env.example .env
```
Update `.env` with your credentials:
```plaintext
DB_HOST=localhost
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=task_manager
JWT_SECRET=your_secret_key
```

### Running the Applications

#### Question 1 - Database Access:
```bash
mysql -u root -p clinic_booking
```

#### Question 2 - API Server:
```bash
cd Question2_TaskManagerAPI
npm start
```
Server runs at: http://localhost:3000

## API Documentation

### Authentication Endpoints
- `POST /api/auth/register` - Register new user
  ```json
  {
    "username": "string",
    "email": "string",
    "password": "string"
  }
  ```
- `POST /api/auth/login` - User login
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```

### Tasks Endpoints
All task endpoints require JWT Authentication header:
`Authorization: Bearer <token>`

- `GET /api/tasks` - Get all tasks
- `GET /api/tasks/:id` - Get specific task
- `POST /api/tasks` - Create task
  ```json
  {
    "title": "string",
    "description": "string",
    "due_date": "YYYY-MM-DD"
  }
  ```
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

### Users Endpoints
Requires admin authorization:

- `GET /api/users` - List users
- `GET /api/users/:id` - Get user details
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

## Error Handling
API returns standard HTTP status codes:
- 200: Success
- 201: Created
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 500: Server Error

## Database Schema
### Question 1: Clinic Booking System
```sql
Tables:
1. patients
   - patient_id (PK)
   - full_name
   - email (UNIQUE)
   - phone_number
   - date_of_birth

2. doctors
   - doctor_id (PK)
   - full_name
   - email (UNIQUE)
   - phone_number

3. specializations
   - specialization_id (PK)
   - specialization_name (UNIQUE)

4. doctor_specializations
   - doctor_id (PK, FK)
   - specialization_id (PK, FK)

5. appointments
   - appointment_id (PK)
   - patient_id (FK)
   - doctor_id (FK)
   - appointment_date
   - appointment_time
   - notes

6. medicines
   - medicine_id (PK)
   - medicine_name
   - dosage_form
   - strength
   - manufacturer
   - stock_quantity
   - price

7. prescribed_medicines
   - prescribed_id (PK)
   - appointment_id (FK)
   - medicine_id (FK)
   - quantity
   - instructions

8. prescriptions
   - prescription_id (PK)
   - appointment_id (FK)
   - prescription_date
   - medicine_ids
   - instructions

9. staff
   - staff_id (PK)
   - full_name
   - role
   - email (UNIQUE)
   - phone_number

10. payments
   - payment_id (PK)
   - patient_id (FK)
   - amount
   - payment_date
   - payment_method

11. medical_history
    - history_id (PK)
    - patient_id (FK)
    - condition_name
    - condition_description
    - diagnosis_date

12. clinic_schedule
    - schedule_id (PK)
    - doctor_id (FK)
    - day_of_week
    - start_time
    - end_time

13. feedback
    - feedback_id (PK)
    - patient_id (FK)
    - doctor_id (FK)
    - feedback_date
    - rating
    - comments

14. user_accounts
    - user_id (PK)
    - username (UNIQUE)
    - password_hash
    - role
    - user_id_ref (FK)
```

### Question 2: Task Manager
```sql
Tables:
1. users
   - id (PK)
   - name
   - email (UNIQUE)

2. tasks
   - id (PK)
   - title
   - description
   - user_id (FK)
   - FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
```

#### Sample Data
```sql
-- Sample Users
INSERT INTO users (name, email) VALUES
  ('Alice', 'alice@example.com'),
  ('Bob', 'bob@example.com'),
  ('Charlie', 'charlie@example.com'),
  ('Dana', 'dana@example.com'),
  ('Erik', 'erik@example.com');

-- Sample Tasks
INSERT INTO tasks (title, description, user_id) VALUES
  ('Complete Assignment', 'Finish the database and API assignment', 1),
  ('Study for Exam', 'Review MySQL and Node.js concepts', 2),
  ('Team Meeting', 'Discuss project milestones and blockers', 2),
  ('Fix Bug #231', 'Resolve login issue reported by QA', 2),
  ('Write Blog Post', 'Write an article for the company blog', 5);
```

#### Database Setup
```bash
# Create and populate database
mysql -u root -p < task_manager_schema.sql
```

#### API Endpoints
All endpoints require JWT Authentication:
`Authorization: Bearer <token>`

- `GET /api/tasks` - List all tasks
- `POST /api/tasks` - Create new task
  ```json
  {
    "title": "string",
    "description": "string",
    "user_id": "number"
  }
  ```
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

## Testing
Run the test suite:
```bash
cd Question2_TaskManagerAPI
npm test
```

## Security Features
- SQL injection prevention (using mysql2 prepared statements)
- Cross-Origin Resource Sharing (CORS) protection
- Password hashing using bcrypt
- JWT authentication
- Environment variable protection
- XSS protection
- Rate limiting

## Technologies Used
- Node.js v14+
- Express.js 4.18+
- MySQL 8.0+
- body-parser
- cors
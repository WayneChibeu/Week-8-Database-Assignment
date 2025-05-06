# Task Manager API

## Description
A simple CRUD API for managing tasks assigned to users, built using Node.js, Express, and MySQL.

## Prerequisites
- Node.js (v14 or higher)
- MySQL (v8.0 or higher)
- npm (Node Package Manager)

## How to Run

1. Clone the repository
2. Install dependencies:
```bash
npm install
```

3. Configure environment variables:
```bash
cp .env.example .env
```
Update `.env` with your database credentials:
```plaintext
# Database Configuration
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=task_manager

# Server Configuration
PORT=3000
```

4. Create the MySQL database:
```bash
mysql -u root -p < task_manager_schema.sql
```

5. Start the API:
```bash
npm start
```
Server runs at: http://localhost:3000

## API Routes

### Tasks
- `GET /api/tasks` - Get all tasks
- `GET /api/tasks/:id` - Get specific task
- `POST /api/tasks` - Create task
```json
{
    "title": "string",
    "description": "string",
    "user_id": "number"
}
```
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

### Users
- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get user details
- `POST /api/users` - Create user
```json
{
    "name": "string",
    "email": "string"
}
```
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

## Error Codes
- 200: Success
- 201: Created
- 400: Bad Request
- 404: Not Found
- 500: Server Error

## Technologies Used
- Express.js 4.18+
- MySQL 8.0+
- body-parser
- cors

## Security Features
- SQL injection prevention (using mysql2 prepared statements)
- Cross-Origin Resource Sharing (CORS) protection

-- 1. Create database
CREATE DATABASE task_manager;
USE task_manager;

-- 2. Create the 'users' table
--    Stores user details
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL
);

-- 3. Create the 'tasks' table
--    Stores tasks assigned to users, linked via user_id
CREATE TABLE tasks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  user_id INT,
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE SET NULL
);

-- 4. Insert sample users
INSERT INTO users (name, email) VALUES
  ('Alice', 'alice@example.com'),
  ('Bob', 'bob@example.com'),
  ('Charlie', 'charlie@example.com'),
  ('Dana', 'dana@example.com'),
  ('Erik', 'erik@example.com');

-- 5. Insert sample tasks for users
INSERT INTO tasks (title, description, user_id) VALUES
  ('Complete Assignment', 'Finish the database and API assignment', 1),
  ('Study for Exam', 'Review MySQL and Node.js concepts', 2),
  ('Grocery Shopping', 'Buy vegetables, fruits, and milk', 1),
  ('Team Meeting', 'Discuss project milestones and blockers', 2),
  ('Call Mom', 'Catch up with mom over the weekend', 1),
  ('Fix Bug #231', 'Resolve login issue reported by QA', 2),
  ('Workout', 'Do a 30-minute home workout routine', 1),
  ('Book Dentist Appointment', 'Routine checkup next week', 2),
  ('Finish Report', 'Write the final project report', 3),
  ('Client Follow-up', 'Follow up on last week\'s meeting with client', 4),
  ('Prepare Presentation', 'Prepare slides for the upcoming presentation', 5),
  ('Weekly Review', 'Review the week\'s work and plan for next week', 3),
  ('Update Website', 'Make changes to the company website', 4),
  ('Write Blog Post', 'Write an article for the company blog', 5);

-- Clinic Booking System - Full SQL Schema and Sample Data
-- Author: Wayne Chibeu
-- Date: 2025-05-05

-- Create Database
CREATE DATABASE clinic_db;
USE clinic_db;

-- Create Patients table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    date_of_birth DATE
);

-- Create Doctors table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20)
);

-- Create Specializations table
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create Doctor_Specializations (many-to-many)
CREATE TABLE doctor_specializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id)
);

-- Create Appointments table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Create Medicines table
CREATE TABLE medicines (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL,
    dosage_form VARCHAR(50) NOT NULL, -- E.g., tablet, syrup, injection
    strength VARCHAR(50), -- E.g., 500mg, 10mg/mL
    manufacturer VARCHAR(100),
    stock_quantity INT NOT NULL, -- Track the quantity available
    price DECIMAL(10, 2) -- Price per unit (optional, can be added later if needed)
);

-- Create Prescribed Medicines table
CREATE TABLE prescribed_medicines (
    prescribed_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    medicine_id INT,
    quantity INT NOT NULL, -- How many units of the medicine prescribed
    instructions TEXT, -- Dosage instructions (e.g., "Take one tablet every 8 hours")
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);

-- Staff table to track clinic staff (e.g., nurses, receptionists)
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(50), -- E.g., Nurse, Receptionist
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20)
);

-- Payments table to track patient payments
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50), -- E.g., Cash, Credit Card, Mobile Payment
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Prescriptions table to store prescription details (if separate from medicines)
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT,
    prescription_date DATE NOT NULL,
    medicine_ids TEXT, -- List of medicine_ids prescribed (stored as a comma-separated string)
    instructions TEXT, -- Dosage instructions
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Medical History table to track patient medical conditions
CREATE TABLE medical_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    condition_name VARCHAR(100) NOT NULL,
    condition_description TEXT,
    diagnosis_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Clinic Schedule table to store doctor availability
CREATE TABLE clinic_schedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    day_of_week VARCHAR(10) NOT NULL, -- E.g., Monday, Tuesday
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Feedback table for patient reviews/ratings
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    feedback_date DATE NOT NULL,
    rating INT NOT NULL, -- E.g., 1-5 scale
    comments TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- User Accounts table for managing system user access (admin, doctors, staff)
CREATE TABLE user_accounts (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Store the hashed password
    role VARCHAR(50) NOT NULL, -- E.g., Admin, Doctor, Receptionist
    user_id_ref INT, -- References either patient_id, doctor_id, or staff_id
    FOREIGN KEY (user_id_ref) REFERENCES doctors(doctor_id), -- For doctors
    FOREIGN KEY (user_id_ref) REFERENCES staff(staff_id) -- For staff
);

-- Insert Patients
INSERT INTO patients (full_name, email, phone_number, date_of_birth) VALUES
('Marianne Nyongesa', 'marianne.nyongesa@outlook.com', '+254712345678', '1992-03-14'),
('David Kimani', 'david.kimani@gmail.com', '+254723456789', '1988-07-22'),
('Leah Mwende', 'leah.mwende@yahoo.com', '+254701234567', '1995-11-30'),
('Brian Otieno', 'brian.otieno@protonmail.com', '+254745678912', '1990-01-08'),
('Cynthia Wairimu', 'cynthia.wairimu@icloud.com', '+254798765432', '1986-06-05');

-- Insert Doctors
INSERT INTO doctors (full_name, email, phone_number) VALUES
('Dr. Grace Okoth', 'grace.okoth@medixclinic.co.ke', '+254700123456'),
('Dr. James Mwangi', 'james.mwangi@medixclinic.co.ke', '+254709876543'),
('Dr. Sarah Wambui', 'sarah.wambui@medixclinic.co.ke', '+254711223344');

-- Insert Specializations
INSERT INTO specializations (specialization_name) VALUES
('Internal Medicine'),
('Dermatology'),
('Pediatrics'),
('Gynecology'),
('Orthopedics');

-- Link Doctors to Specializations
INSERT INTO doctor_specializations (doctor_id, specialization_id) VALUES
(1, 1),
(1, 4),
(2, 2),
(2, 5),
(3, 3),
(3, 4);

-- Insert Medicines
INSERT INTO medicines (medicine_name, dosage_form, strength, manufacturer, stock_quantity, price) VALUES
('Paracetamol', 'Tablet', '500mg', 'ABC Pharma', 100, 5.00),
('Amoxicillin', 'Capsule', '250mg', 'XYZ Pharmaceuticals', 50, 10.00),
('Cetirizine', 'Syrup', '10mg/5mL', 'HealthCare Ltd.', 200, 3.50),
('Ibuprofen', 'Tablet', '200mg', 'FastMeds Inc.', 150, 8.00);

-- Insert Staff
INSERT INTO staff (full_name, role, email, phone_number) VALUES
('Nina Karanja', 'Nurse', 'nina.karanja@medixclinic.co.ke', '+254700987654'),
('Eric Otieno', 'Receptionist', 'eric.otieno@medixclinic.co.ke', '+254701234567');

-- Insert Payments
INSERT INTO payments (patient_id, amount, payment_date, payment_method) VALUES
(1, 1000.00, '2025-05-05', 'Mobile Payment'),
(2, 1500.00, '2025-05-06', 'Credit Card');

-- Insert Medical History
INSERT INTO medical_history (patient_id, condition_name, condition_description, diagnosis_date) VALUES
(1, 'Hypertension', 'High blood pressure diagnosed during a routine check-up', '2023-08-15'),
(2, 'Asthma', 'Chronic asthma condition, requires inhalers', '2022-10-20');

-- Insert Clinic Schedule
INSERT INTO clinic_schedule (doctor_id, day_of_week, start_time, end_time) VALUES
(1, 'Monday', '08:00:00', '12:00:00'),
(2, 'Tuesday', '09:00:00', '13:00:00'),
(3, 'Wednesday', '10:00:00', '14:00:00');

-- Insert Feedback
INSERT INTO feedback (patient_id, doctor_id, feedback_date, rating, comments) VALUES
(1, 1, '2025-05-07', 5, 'Great experience, very professional!'),
(2, 2, '2025-05-08', 4, 'Good consultation, but the wait time was long.');

-- Insert User Accounts (Admin, Doctor, Staff)
INSERT INTO user_accounts (username, password_hash, role, user_id_ref) VALUES
('admin', 'hashed_password_123', 'Admin', NULL),
('dr.grace', 'hashed_password_456', 'Doctor', 1),
('nina', 'hashed_password_789', 'Staff', 1);


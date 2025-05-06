// Import your MySQL connection
const db = require('../db');

// Get all users
exports.getUsers = (req, res) => {
  const query = 'SELECT * FROM users';
  
  db.query(query, (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Database error', error: err });
    }
    res.status(200).json(result);
  });
};

// Get a specific user by ID
exports.getUserById = (req, res) => {
  const userId = req.params.id;
  const query = 'SELECT * FROM users WHERE id = ?';
  
  db.query(query, [userId], (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Database error', error: err });
    }
    if (result.length === 0) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json(result[0]);
  });
};

// Create a new user
exports.createUser = (req, res) => {
  const { name, email } = req.body;
  const query = 'INSERT INTO users (name, email) VALUES (?, ?)';
  
  db.query(query, [name, email], (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Database error', error: err });
    }
    res.status(201).json({ message: 'User created', userId: result.insertId });
  });
};

// Update an existing user
exports.updateUser = (req, res) => {
  const userId = req.params.id;
  const { name, email } = req.body;
  const query = 'UPDATE users SET name = ?, email = ? WHERE id = ?';
  
  db.query(query, [name, email, userId], (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Database error', error: err });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json({ message: 'User updated' });
  });
};

// Delete a user
exports.deleteUser = (req, res) => {
  const userId = req.params.id;
  const query = 'DELETE FROM users WHERE id = ?';
  
  db.query(query, [userId], (err, result) => {
    if (err) {
      return res.status(500).json({ message: 'Database error', error: err });
    }
    if (result.affectedRows === 0) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json({ message: 'User deleted' });
  });
};

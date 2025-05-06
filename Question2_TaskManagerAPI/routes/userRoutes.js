const express = require('express');
const router = express.Router();

// Import the controller
const userController = require('../controllers/userController');

// Define routes
router.get('/', userController.getUsers);           // Get all users
router.get('/:id', userController.getUserById);     // Get a user by ID
router.post('/', userController.createUser);        // Create a new user
router.put('/:id', userController.updateUser);      // Update an existing user
router.delete('/:id', userController.deleteUser);   // Delete a user

module.exports = router;

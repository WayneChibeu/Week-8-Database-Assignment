const express = require('express');
const router = express.Router();

// Import the task controller
const taskController = require('../controllers/taskController');

// Define task routes
router.get('/', taskController.getAllTasks);         // Get all tasks
router.get('/:id', taskController.getTaskById);      // Get a task by ID
router.post('/', taskController.createTask);         // Create a new task
router.put('/:id', taskController.updateTask);       // Update a task
router.delete('/:id', taskController.deleteTask);    // Delete a task

module.exports = router;

const db = require('../db');

exports.getAllTasks = (req, res) => {
    db.query(`
        SELECT tasks.*, users.name AS assigned_user
        FROM tasks
        LEFT JOIN users ON tasks.user_id = users.id
    `, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
};


exports.getTaskById = (req, res) => {
    const id = req.params.id;
    db.query('SELECT * FROM tasks WHERE id = ?', [id], (err, result) => {
        if (err) throw err;
        res.json(result[0]);
    });
};

exports.createTask = (req, res) => {
    const { title, description, user_id } = req.body;
    db.query(
        'INSERT INTO tasks (title, description, user_id) VALUES (?, ?, ?)',
        [title, description, user_id],
        (err, result) => {
            if (err) throw err;
            res.json({ id: result.insertId, title, description, user_id });
        }
    );
};

exports.updateTask = (req, res) => {
    const id = req.params.id;
    const { title, description } = req.body;
    db.query('UPDATE tasks SET title = ?, description = ? WHERE id = ?', [title, description, id], (err) => {
        if (err) throw err;
        res.json({ id, title, description });
    });
};

exports.deleteTask = (req, res) => {
    const id = req.params.id;
    db.query('DELETE FROM tasks WHERE id = ?', [id], (err) => {
        if (err) throw err;
        res.json({ message: 'Task deleted successfully' });
    });
};
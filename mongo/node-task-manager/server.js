const express = require("express");
const mongoose = require("mongoose");

const app = express();
app.use(express.json()); // Middleware to parse JSON

// Connect to MongoDB
mongoose.connect("mongodb://localhost:27017/taskdb", {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

// Define Task Schema & Model
const taskSchema = new mongoose.Schema({
    task: String,
    status: String,
	priority: String,
	dueDate: String
});
const Task = mongoose.model("Task", taskSchema);

// Create a Task (POST)
app.post("/tasks", async (req, res) => {
    try {
        const task = new Task(req.body);
        await task.save();
        res.status(201).send(task);
    } catch (error) {
        res.status(500).send({ error: "Failed to create task" });
    }
});

// Get All Tasks (GET)
app.get("/tasks", async (req, res) => {
    try {
        const tasks = await Task.find();
        res.send(tasks);
    } catch (error) {
        res.status(500).send({ error: "Failed to fetch tasks" });
    }
});

// Update a Task (PUT)
app.put("/tasks/:id", async (req, res) => {
    try {
        const task = await Task.findByIdAndUpdate(req.params.id, req.body, { new: true });
        if (!task) return res.status(404).send({ error: "Task not found" });
        res.send(task);
    } catch (error) {
        res.status(500).send({ error: "Failed to update task" });
    }
});

// Delete a Task (DELETE)
app.delete("/tasks/:id", async (req, res) => {
    try {
        const task = await Task.findByIdAndDelete(req.params.id);
        if (!task) return res.status(404).send({ error: "Task not found" });
        res.send({ message: "Task deleted successfully" });
    } catch (error) {
        res.status(500).send({ error: "Failed to delete task" });
    }
});

// Start Server
app.listen(3000, () => console.log("Server running on port 3000"));
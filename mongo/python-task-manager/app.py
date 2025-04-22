from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson.objectid import ObjectId

app = Flask(__name__)
app.config["MONGO_URI"] = "mongodb://localhost:27017/taskdb"
mongo = PyMongo(app)

# Create a Task (POST)
@app.route("/tasks", methods=["POST"])
def create_task():
    data = request.json
    task = {
        "title": data.get("title"),
        "description": data.get("description"),
        "status": data.get("status"),
        "priority": data.get("priority")
    }
    task_id = mongo.db.tasks.insert_one(task).inserted_id
    return jsonify({"taskId": str(task_id), "message": "Task created"}), 201

# Get All Tasks (GET)
@app.route("/tasks", methods=["GET"])
def get_tasks():
    tasks = mongo.db.tasks.find()
    result = [{"taskId": str(task["_id"]), **task} for task in tasks]
    return jsonify(result)

# Update a Task (PUT)
@app.route("/tasks/<task_id>", methods=["PUT"])
def update_task(task_id):
    data = request.json
    updated_task = mongo.db.tasks.find_one_and_update(
        {"_id": ObjectId(task_id)},
        {"$set": data},
        return_document=True
    )
    if updated_task:
        return jsonify({"message": "Task updated"})
    return jsonify({"error": "Task not found"}), 404

# Delete a Task (DELETE)
@app.route("/tasks/<task_id>", methods=["DELETE"])
def delete_task(task_id):
    deleted = mongo.db.tasks.delete_one({"_id": ObjectId(task_id)})
    if deleted.deleted_count > 0:
        return jsonify({"message": "Task deleted"})
    return jsonify({"error": "Task not found"}), 404

if __name__ == "__main__":
    app.run(debug=True)
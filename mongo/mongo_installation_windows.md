# MongoDB Installation Guide for Windows

## ✅ Part 1: Installing MongoDB Server

### Step 1: Download MongoDB
- Visit the official MongoDB Community Edition download page:  
  [https://www.mongodb.com/try/download/community](https://www.mongodb.com/try/download/community)
- Choose:
  - **Version**: Current or LTS
  - **OS**: Windows
  - **Package**: MSI
- Click **Download** and save the installer.

### Step 2: Install MongoDB
1. Run the downloaded `.msi` installer.
2. Select **Complete** setup.
3. Choose **Install MongoDB as a Service**.
4. Keep the default service configuration (run as `Network Service`).
5. Optionally, install **MongoDB Compass**.
6. Complete the installation.

### Step 3: Set Environment Variable
1. Go to `C:\Program Files\MongoDB\Server\<version>\bin`
2. Copy the path.
3. Open **System Properties > Environment Variables**
4. Under **System variables**, edit **Path**
5. Add the copied MongoDB `bin` path.

### Step 4: Create Data Directory
```bash
mkdir C:\data\db
```

### Step 5: Start MongoDB Server
If installed as a service:

Go to windows services and Start MongoDB service.

Or to run manually:
```bash
mongod
```

---

## ✅ Part 2: MongoDB Clients (Read/Write Access)

### 1. MongoDB Shell (mongosh)
- Download: [https://www.mongodb.com/try/download/shell](https://www.mongodb.com/try/download/shell)
- Usage:
```bash
mongosh
mongosh "mongodb://localhost:27017"
```

### 2. MongoDB Compass (GUI)
- GUI for exploring data and building queries
- Download: [https://www.mongodb.com/products/compass](https://www.mongodb.com/products/compass)

### 3. Robo 3T (Robomongo)
- Lightweight GUI client  
- Download: [https://robomongo.org](https://robomongo.org)

### 4. Programmatic Drivers
Official drivers for various languages:
- **Python**: `pip install pymongo`
- **Node.js**: `npm install mongodb`
- **Java**: MongoDB Java Driver
- **C#**: MongoDB.Driver (NuGet)

Example in Python:
```python
from pymongo import MongoClient
client = MongoClient("mongodb://localhost:27017/")
print(client.list_database_names())
```

---

## ✅ Part 3: Basic Commands to Verify Installation

Run in `mongosh`:
```bash
show dbs
use testdb
db.users.insertOne({ name: "Alice", age: 25 })
db.users.find()
show collections
```

---

## ✅ Part 4: Troubleshooting

| Issue                       | Solution                                      |
|-----------------------------|-----------------------------------------------|
| `'mongod' not recognized`   | Ensure `bin` path is added to system PATH     |
| `data/db not found`         | Create `C:\data\db` manually                  |
| Port conflict               | Run `mongod` with `--port <custom_port>`      |
| MongoDB service not starting| Check logs in Windows Event Viewer            |

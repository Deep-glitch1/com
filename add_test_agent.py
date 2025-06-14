import os
from dotenv import load_dotenv
import pymongo
from werkzeug.security import generate_password_hash
import uuid

# Load environment variables
load_dotenv()
mongo_uri = os.getenv("MONGO_URI")
if not mongo_uri:
    raise ValueError("MONGO_URI not set in environment variables")

# Connect to MongoDB
mongo_client = pymongo.MongoClient(mongo_uri)
db = mongo_client["Secure-Delivery-Data"]
agents_collection = db["agents"]

# Create a test agent
test_agent = {
    "agent_id": str(uuid.uuid4()),
    "username": "test_agent",
    "email": "test_agent@example.com",
    "phone": "1234567890",
    "password": generate_password_hash("test123"),
    "orders": []
}

# Insert the test agent
try:
    result = agents_collection.insert_one(test_agent)
    print(f"Test agent added successfully with ID: {result.inserted_id}")
except Exception as e:
    print(f"Error adding test agent: {str(e)}") 
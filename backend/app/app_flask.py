from flask import Flask, jsonify, request
from pymongo import MongoClient
from dotenv import load_dotenv
import os
from datetime import datetime

load_dotenv()

mongo_uri = os.environ.get('MONGO_URI')

app = Flask(__name__)

client = MongoClient(mongo_uri)
db = client["MLH_DB"]
collection = db["Forest_Entries"]

@app.route('/')
def home():
    return """
    <h1>Welcome to Forest Entries API</h1>
    <p>Available endpoints:</p>
    <ul>
        <li><a href="/api/get-all-entries">/api/get-all-entries</a> - Get all entries (GET)</li>
    </ul>
    """

@app.route('/api/get-all-entries', methods=['GET'])
def get_all_entries():
    try:
        all_entries = list(collection.find())
        for entry in all_entries:
            entry['_id'] = str(entry['_id'])
        return jsonify(all_entries), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@app.route('/api/data', methods=['POST'])
def handle_data():
    data = request.get_json()
    required_fields = ["Angle", "Fire_Detected", "GPS", "Pi_id", "Time"]
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    inserted_id = collection.insert_one(data).inserted_id

    return jsonify({"message": "Data inserted successfully", "id": str(inserted_id)}), 201

if __name__ == '__main__':
    app.run(port=5001, debug=True)

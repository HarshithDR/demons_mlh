from flask import Flask, jsonify, request
from pymongo import MongoClient
from dotenv import load_dotenv
import os
from datetime import datetime
import pytz 

load_dotenv()

mongo_uri = os.environ.get('MONGO_URI')

app = Flask(__name__)

client = MongoClient(mongo_uri)
db = client["MLH_DB"]
collection = db["Forest_Entries"]

def get_current_cst_time():
    utc_now = datetime.now(pytz.utc)
    cst = pytz.timezone('America/Chicago')
    cst_now = utc_now.astimezone(cst)

    return cst_now.strftime("%H:%M:%S")

@app.route('/')
def home():
    return """
    <h1>Welcome to Forest Entries API</h1>
    <p>Available endpoints:</p>
    <ul>
        <li><a href="/api/get-all-entries">/api/get-all-entries</a> - Get all entries (GET)</li>
        <li><a href="/api/check-fire">/api/check-fire</a> - Check latest entry for fire detection (GET)</li>
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
    required_fields = ["Angle", "Fire_Detected", "GPS", "Pi_id"]  
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

   
    data['Time'] = get_current_cst_time()
    
    inserted_id = collection.insert_one(data).inserted_id

    return jsonify({
        "message": "Data inserted successfully",
        "id": str(inserted_id),
        "time_recorded": data['Time']  
    }), 201

@app.route('/api/check-fire', methods=['GET'])
def check_fire():
    try:
        latest_entry = collection.find_one(sort=[('_id', -1)])
        
        if not latest_entry:
            return jsonify({"message": "No entries found in database"}), 404
            
        latest_entry['_id'] = str(latest_entry['_id'])
        
        fire_detected = latest_entry.get('Fire_Detected', False)
        if fire_detected == 'Yes' or fire_detected is True:
            return jsonify({
                "alert": "fire fire",
                "details": latest_entry,
                "timestamp": get_current_cst_time()  
            }), 200
        else:
            return jsonify({
                "message": "No fire detected in latest entry",
                "details": latest_entry,
                "current_time": get_current_cst_time()  
            }), 200
            
    except Exception as e:
        return jsonify({"error": str(e)}), 500




if __name__ == '__main__':
    app.run(port=5001, debug=True)
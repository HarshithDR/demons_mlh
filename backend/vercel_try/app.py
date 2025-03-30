from flask import Flask, jsonify, request
from pymongo import MongoClient
from dotenv import load_dotenv
import os
from datetime import datetime
import pytz 
from flask_cors import CORS  

load_dotenv()

mongo_uri = os.environ.get('MONGO_URI')

app = Flask(__name__)
CORS(app)  

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
        all_entries = list(collection.find({}, {'_id': 0}))  
        return jsonify(all_entries), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@app.route('/api/data', methods=['POST'])
def handle_data():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "No data provided"}), 400
            
        required_fields = ["Angle", "Fire_Detected", "GPS", "Pi_id"]  
        if not all(field in data for field in required_fields):
            return jsonify({"error": "Missing required fields"}), 400

        data['Time'] = get_current_cst_time()
        data['timestamp'] = datetime.utcnow()  
    
        inserted_id = collection.insert_one(data).inserted_id

        return jsonify({
            "message": "Data inserted successfully",
            "id": str(inserted_id),
            "time_recorded": data['Time']
        }), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/check-fire', methods=['GET'])
def check_fire():
    try:
        latest_entry = collection.find_one(
            sort=[('timestamp', -1)],  
            projection={'_id': 0}  
        )
        
        if not latest_entry:
            return jsonify({"message": "No entries found in database"}), 404
            
        fire_detected = latest_entry.get('Fire_Detected', False)
        response = {
            "details": latest_entry,
            "server_time": get_current_cst_time()
        }
        
        if fire_detected in ('Yes', True, 'true', 1):
            response["alert"] = "FIRE DETECTED!"
            return jsonify(response), 200
        else:
            response["message"] = "No fire detected"
            return jsonify(response), 200
            
    except Exception as e:
        return jsonify({"error": str(e)}), 500

def vercel_handler(request):
    from flask import Response
    with app.app_context():
        response = app.full_dispatch_request()
        return Response(
            response=response.get_data(),
            status=response.status_code,
            headers=dict(response.headers)
        )

if __name__ == '__main__':
    app.run(port=5001, debug=True)
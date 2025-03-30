import os
import time
from pymongo import MongoClient
from dotenv import load_dotenv
from datetime import datetime

load_dotenv()
mongo_uri = os.environ.get('MONGO_URI')
client = MongoClient(mongo_uri)

db = client["MLH_DB"]

collection = db["Forest_Entries"]

test_doc = {
    "Time": datetime.now(),
    "Pi_id": 1,  
    "Fire_Detected": False,  
    "Angle": 145,  
    "GPS": 1215 
}

result = collection.insert_one(test_doc)

print("Inserted ID:", result.inserted_id)


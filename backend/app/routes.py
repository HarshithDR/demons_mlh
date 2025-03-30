from flask import Flask, jsonify, request
from pymongo import MongoClient
from dotenv import load_dotenv
import os
import gradio as gr
import threading
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
        <li><a href="/gradio-interface">/gradio-interface</a> - Gradio interface</li>
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

def gradio_interface():
    try:
        all_entries = list(collection.find().sort("created_at", -1))
        
        if not all_entries:
            return "No entries found in the database."
            
        formatted_entries = []
        for entry in all_entries:
            entry_str = f"Entry ID: {str(entry['_id'])}\n"
            entry_str += f"Created at: {entry.get('created_at', 'N/A')}\n"
            for key, value in entry.items():
                if key not in ['_id', 'created_at']:
                    entry_str += f"{key}: {value}\n"
            formatted_entries.append(entry_str)
        
        return "\n\n".join(formatted_entries)
    except Exception as e:
        return f"Error: {str(e)}"

iface = gr.Interface(
    fn=gradio_interface,
    inputs=None,
    outputs=gr.Textbox(label="Forest Entries", lines=20),
    title="Forest Entries Viewer",
    description="Displaying all entries from the Forest collection",
    allow_flagging="never"
)

gradio_app = iface

def run_gradio():
    gradio_app.launch(server_name="0.0.0.0", server_port=7860, share=True)

@app.route('/gradio-interface')
def redirect_to_gradio():
    return """
    <script>
        window.location.href = "http://localhost:7860";
    </script>
    <p>Redirecting to Gradio interface... If not redirected, <a href="http://localhost:7860">click here</a></p>
    """

if __name__ == '__main__':
    threading.Thread(target=run_gradio, daemon=True).start()
    app.run(port=5001, debug=True)

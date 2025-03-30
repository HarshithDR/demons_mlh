from flask import Flask, request, jsonify
import base64
import io  # This was missing
import os
from keras.preprocessing import image
import numpy as np
from keras.models import load_model

app = Flask(__name__)

# Load model (put your model.h5 in the same folder)
model = load_model('model.h5')
classes = ['Fresh Apple', 'Fresh Banana', 'Fresh Orange',
           'Rotten Apple', 'Rotten Banana', 'Rotten Orange']

@app.route('/get_blob', methods=['GET'])
def get_blob():
    """Converts image.jpg to base64 blob"""
    try:
        with open("uploads/Rotten_Banana.png", "rb") as img_file:
            blob = base64.b64encode(img_file.read()).decode('utf-8')
        return jsonify({"blob": blob})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/predict', methods=['POST'])
def predict():
    """Accepts base64 blob and returns prediction"""
    try:
        data = request.get_json()
        if not data or 'blob' not in data:
            return jsonify({"error": "Send JSON with 'blob' field"}), 400
            
        # Decode image
        img_bytes = base64.b64decode(data['blob'])
        img = image.load_img(io.BytesIO(img_bytes), target_size=(64, 64))
        
        # Predict
        img_array = image.img_to_array(img)
        img_array = np.expand_dims(img_array, axis=0)/255.0
        pred = model.predict(img_array)
        
        return jsonify({
            "class": classes[np.argmax(pred)],
            "confidence": float(np.max(pred))
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/check-image', methods=['POST'])
def check_image():
    try:
        from gradio_client import Client, handle_file
        
        client = Client("https://88f6fc47f3c520b45f.gradio.live/")
        result = client.predict(
            input_image=handle_file('https://raw.githubusercontent.com/gradio-app/gradio/main/test/test_files/bus.png'),
            api_name="/predict"
        )
        
        return jsonify({
            "result": result,
            "status": "success",
            "timestamp": get_current_cst_time()
        }), 200
        
    except Exception as e:
        return jsonify({
            "error": str(e),
            "status": "failed",
            "timestamp": get_current_cst_time()
        }), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002, debug=True)
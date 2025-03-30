import gradio as gr
import base64
import io
from keras.preprocessing import image
import numpy as np
from keras.models import load_model

# Load model and classes (same as your original code)
model = load_model('model.h5')
classes = ['Fresh Apple', 'Fresh Banana', 'Fresh Orange',
           'Rotten Apple', 'Rotten Banana', 'Rotten Orange']

def predict_from_blob(blob):
    """Gradio-compatible prediction function"""
    try:
        # Decode image (same as your Flask endpoint)
        img_bytes = base64.b64decode(blob)
        img = image.load_img(io.BytesIO(img_bytes), target_size=(64, 64))
        
        # Predict
        img_array = image.img_to_array(img)
        img_array = np.expand_dims(img_array, axis=0)/255.0
        pred = model.predict(img_array)
        
        return {
            "class": classes[np.argmax(pred)],
            "confidence": float(np.max(pred))
        }
    except Exception as e:
        return {"error": str(e)}

# Gradio Interface
def process_image(input_image):
    """Convert uploaded image to base64 and predict"""
    buffered = io.BytesIO()
    input_image.save(buffered, format="PNG")
    img_blob = base64.b64encode(buffered.getvalue()).decode("utf-8")
    return predict_from_blob(img_blob)

# Create Gradio UI
interface = gr.Interface(
    fn=process_image,
    inputs=gr.Image(type="pil", label="Upload Fruit Image"),
    outputs=gr.JSON(label="Prediction"),
    title="Fruit Freshness Classifier",
    description="Upload an image to check if it's fresh or rotten",
    examples=[
        ["examples/fresh_apple.jpg"],
        ["examples/rotten_banana.jpg"]
    ]
)

# For Hugging Face Spaces
interface.launch(share=True, show_error=True)
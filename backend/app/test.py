import gradio as gr
import requests


import requests

def function_one(input_text):
    try:
        # Make a GET request to the localhost route
        response = requests.get('http://127.0.0.1:5001/api/get-all-entries')

        # Check if the request was successful
        if response.status_code == 200:
            # Process and return the response data
            return f"Function One processed: {response.json()}"
        else:
            return f"Failed to get data. Status code: {response.status_code}, Reason: {response.reason}"
    except requests.exceptions.RequestException as e:
        # Handle exceptions such as connection errors
        return f"An error occurred: {str(e)}"


def function_two(input_text):
    return f"Function Two processed: {input_text}"

with gr.Blocks() as app:
    gr.Markdown("# Basic Gradio App")

    with gr.Row():
        input_box = gr.Textbox(label="Enter your text here")

    with gr.Row():
        btn_one = gr.Button("Run Function One")
        btn_two = gr.Button("Run Function Two")

    with gr.Row():
        output_box = gr.Textbox(label="Output", interactive=False)

    btn_one.click(fn=function_one, inputs=input_box, outputs=output_box)
    btn_two.click(fn=function_two, inputs=input_box, outputs=output_box)

if __name__ == "__main__":
    app.launch(share=True)

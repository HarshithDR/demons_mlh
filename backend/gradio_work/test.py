from gradio_client import Client, handle_file

client = Client("https://88f6fc47f3c520b45f.gradio.live/")
result = client.predict(
		input_image=handle_file('https://raw.githubusercontent.com/gradio-app/gradio/main/test/test_files/bus.png'),
		api_name="/predict"
)
print(result)
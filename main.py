import requests
import json

def send_sensor_data_to_vercel_api(data):
    api_url = "https://vercel-zz1tl98to-nishchals-projects-80d9f9a5.vercel.app/api/data"
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }

    try:
        if isinstance(data.get("Fire_Detected"), bool):
            data["Fire_Detected"] = "Yes" if data["Fire_Detected"] else "No"
        
        response = requests.post(
            api_url,
            data=json.dumps(data),
            headers=headers
        )
        if response.status_code == 201:
            return {
                "success": True,
                "message": "Data sent successfully",
                "api_response": response.json()
            }
        else:
            return {
                "success": False,
                "message": f"API returned status code {response.status_code}",
                "api_response": response.text
            }
            
    except Exception as e:
        return {
            "success": False,
            "message": f"Error sending data: {str(e)}"
        }


if __name__ == "__main__":
    # Harshit get the data from the sensor in the below format as a dict
    sensor_data = {
        "Angle": 10,
        "Fire_Detected": "Yes",
        "GPS": "12.3456,78.9012",
        "Pi_id": "1"
    }
    
    result = send_sensor_data_to_vercel_api(sensor_data)
    print(result)
    

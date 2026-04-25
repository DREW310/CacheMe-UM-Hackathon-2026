import requests

# Your team's ILMU key
api_key = "sk-1f906ef77fb94e81ab62b3a6e61060918dbca4fb6c616c9e" 
url = "https://api.ilmu.ai/v1/chat/completions"

headers = {
    "Authorization": f"Bearer {api_key}",
    "Content-Type": "application/json"
}

payload = {
    "model": "ilmu-glm-5.1",
    "messages": [{"role": "user", "content": "Hello ILMU! Are you online and working?"}]
}

print("Testing API connection...")

try:
    response = requests.post(url, headers=headers, json=payload)
    response.raise_for_status()
    
    # If successful, extract and print the AI's reply
    ai_reply = response.json()['choices'][0]['message']['content']
    print("\n✅ API is working perfectly! AI says:")
    print(f"'{ai_reply}'")

except Exception as e:
    print(f"\n❌ Error connecting to API: {e}")
    if hasattr(e, 'response') and e.response is not None:
        print(f"Details: {e.response.text}")
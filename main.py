from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import json

app = FastAPI()

# Allow our frontend to communicate with this backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # In production, replace with your actual website URL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define the data structure we expect from the frontend
class ChatRequest(BaseModel):
    message: str
    session_id: str

# Our mock state database (in a real app, use a real database)
session_states = {}

# --- The GLM Logic (from previous step) ---
"""
def run_glm_reasoning_engine(customer_message, workflow_state):
    # Mocking the GLM response based on the input
    if "order id" not in customer_message.lower() and "status" in workflow_state.get("status", "new"):
        return {
            "thought_process": "Missing order ID.",
            "action": "ASK_CLARIFICATION",
            "reply_to_customer": "I can help with that! Could you please provide your order ID?"
        }
    else:
        return {
            "thought_process": "Information complete. Resolving.",
            "action": "RESOLVE",
            "reply_to_customer": "Thank you! I have checked order #1234. It is out for delivery."
        }
"""
# Main function to call the GLM API
def run_glm_reasoning_engine(customer_message, workflow_state):
    
    # 1. Prepare the prompt for the GLM
    system_prompt = """
    You are the central reasoning engine for a Customer Support Workflow.
    Analyze the user's message and current state.
    Output ONLY valid JSON with keys: thought_process, action, reply_to_customer.
    """
    
    user_prompt = f"Current State: {workflow_state} | User Message: {customer_message}"

    # 2. Set up the API endpoint and your secret key
    api_url = "https://api.z.ai/v1/chat/completions" # <-- Replace with actual Z.AI URL
    api_key = "YOUR_Z_AI_API_KEY_HERE"             # <-- Replace with your real token

    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    # 3. Format the payload according to the API's documentation
    payload = {
        "model": "glm-main", # <-- Replace with the correct model ID
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt}
        ]
    }

    # 4. Make the call to the GLM API
    try:
        response = requests.post(api_url, headers=headers, json=payload)
        response.raise_for_status() # Check for errors (like 404 or 401)
        
        # 5. Extract the AI's answer
        response_data = response.json()
        ai_message_string = response_data['choices'][0]['message']['content']
        
        # 6. Convert the AI's JSON string back into a Python dictionary
        glm_decision = json.loads(ai_message_string)
        
        return glm_decision

    except Exception as e:
        print(f"API Error: {e}")
        # Fallback response if the API crashes
        return {
            "thought_process": "API call failed.",
            "action": "ERROR",
            "reply_to_customer": "I am currently experiencing technical difficulties. Please hold on."
        }

# --- The Web API Endpoint ---
@app.post("/api/chat")
async def chat_endpoint(request: ChatRequest):
    # Retrieve or create state for this user session
    state = session_states.get(request.session_id, {"status": "new"})
    
    # Run the engine
    glm_decision = run_glm_reasoning_engine(request.message, state)
    
    # Update state based on decision (simplified)
    if glm_decision["action"] == "ASK_CLARIFICATION":
        state["status"] = "awaiting_info"
    
    session_states[request.session_id] = state
    
    return {"reply": glm_decision["reply_to_customer"], "action": glm_decision["action"]}

# To run the server, use this command in your terminal:
# uvicorn main:app --reload
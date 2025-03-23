from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import joblib
import numpy as np
import pandas as pd
import uvicorn

# Initialize FastAPI app
app = FastAPI()

# Load the saved model
def load_model(model_path='best_model.pkl'):
    try:
        model = joblib.load(model_path)
        print("Model loaded successfully!")
        return model
    except Exception as e:
        print(f"Error loading the model: {e}")
        return None

# Load the model
model = load_model()

# Check if the model is loaded
if model is None:
    raise Exception("Model could not be loaded. Check the model file and dependencies.")

# Define the input data schema using Pydantic
class PredictionInput(BaseModel):
    AGE: int
    GENDER: int
    SMOKING: int
    FINGER_DISCOLORATION: int
    MENTAL_STRESS: int
    EXPOSURE_TO_POLLUTION: int
    LONG_TERM_ILLNESS: int
    ENERGY_LEVEL: float
    IMMUNE_WEAKNESS: int
    BREATHING_ISSUE: int
    ALCOHOL_CONSUMPTION: int
    THROAT_DISCOMFORT: int
    OXYGEN_SATURATION: float
    CHEST_TIGHTNESS: int
    FAMILY_HISTORY: int
    SMOKING_FAMILY_HISTORY: int
    STRESS_IMMUNE: int

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define the prediction endpoint
@app.post('/predict')
def predict(input: PredictionInput):
    try:
        # Convert input data to a pandas DataFrame with feature names
        feature_names = [
            'AGE', 'GENDER', 'SMOKING', 'FINGER_DISCOLORATION', 'MENTAL_STRESS',
            'EXPOSURE_TO_POLLUTION', 'LONG_TERM_ILLNESS', 'ENERGY_LEVEL',
            'IMMUNE_WEAKNESS', 'BREATHING_ISSUE', 'ALCOHOL_CONSUMPTION',
            'THROAT_DISCOMFORT', 'OXYGEN_SATURATION', 'CHEST_TIGHTNESS',
            'FAMILY_HISTORY', 'SMOKING_FAMILY_HISTORY', 'STRESS_IMMUNE'
        ]
        input_data = pd.DataFrame([input.dict()], columns=feature_names)
        
        # Make prediction
        prediction = model.predict(input_data)
        
        # Round the prediction to 0 or 1 (binary classification)
        prediction = round(prediction[0])
        
        # Return the prediction
        return {"prediction": prediction}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

# Run the FastAPI app
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
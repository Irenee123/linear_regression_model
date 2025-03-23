# Lung Cancer Predictor

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [How It Works](#how-it-works)
5. [API Endpoint](#api-endpoint)
6. [Flutter App](#flutter-app)
7. [Installation](#installation)
8. [Usage](#usage)
9. [Contributing](#contributing)
10. [License](#license)

---

## Introduction
The **Lung Cancer Predictor** is a machine learning-based application designed to predict the likelihood of lung cancer based on various health-related features. This project consists of:
- A **FastAPI backend** that serves a machine learning model for predictions.
- A **Flutter frontend** that allows users to input their health data and view predictions.

This project aims to provide an easy-to-use tool for individuals to assess their risk of lung cancer based on key health indicators.

---

## Features
- **FastAPI Backend**:
  - RESTful API endpoint for making predictions.
  - Input validation using Pydantic.
  - Hosted on Render for public access.
- **Flutter Frontend**:
  - User-friendly interface for inputting health data.
  - Displays prediction results or error messages.
  - Supports multiple pages for input and results.
- **Machine Learning Model**:
  - Trained on a dataset with multiple health-related features.
  - Predicts the likelihood of lung cancer (binary classification).

---

## Technologies Used
- **Backend**:
  - Python
  - FastAPI
  - Pydantic
  - Scikit-learn
  - Joblib (for model serialization)
- **Frontend**:
  - Flutter
  - Dart
  - HTTP package (for API communication)
- **Hosting**:
  - Render (for backend API)
  - GitHub (for code repository)

---

## How It Works
1. **Data Collection**:
   - The model is trained on a dataset containing features such as age, gender, smoking status, oxygen saturation, and more.
2. **Model Training**:
   - A linear regression model is trained to predict the likelihood of lung cancer.
3. **API Deployment**:
   - The trained model is serialized and integrated into a FastAPI backend.
4. **User Interaction**:
   - Users input their health data into the Flutter app.
   - The app sends the data to the FastAPI endpoint.
   - The API returns the prediction, which is displayed in the app.

---

## API Endpoint
The FastAPI backend provides a single endpoint for making predictions:

- **URL**: `https://your-api-url.com/predict`
- **Method**: `POST`
- **Input**: JSON object with the following fields:
  ```json
  {
    "AGE": 45,
    "GENDER": 1,
    "SMOKING": 0,
    "FINGER_DISCOLORATION": 0,
    "MENTAL_STRESS": 1,
    "EXPOSURE_TO_POLLUTION": 0,
    "LONG_TERM_ILLNESS": 0,
    "ENERGY_LEVEL": 7.5,
    "IMMUNE_WEAKNESS": 0,
    "BREATHING_ISSUE": 0,
    "ALCOHOL_CONSUMPTION": 1,
    "THROAT_DISCOMFORT": 0,
    "OXYGEN_SATURATION": 98.0,
    "CHEST_TIGHTNESS": 0,
    "FAMILY_HISTORY": 0,
    "SMOKING_FAMILY_HISTORY": 0,
    "STRESS_IMMUNE": 0
  }
  ```
- **Output**: JSON object with the prediction:
  ```json
  {
    "prediction": 0
  }
  ```

---

## Flutter App
The Flutter app provides a user-friendly interface for interacting with the API. It includes:
- **Input Page**:
  - TextFields for each input variable.
  - A "Predict" button to submit the data.
- **Result Page**:
  - Displays the prediction result or an error message.

### Screenshots
*(Add screenshots of your Flutter app here.)*

---

## Installation
### Backend
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/lung-cancer-predictor.git
   cd lung-cancer-predictor/backend
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the FastAPI server:
   ```bash
   uvicorn main:app --reload
   ```

### Frontend
1. Navigate to the Flutter app directory:
   ```bash
   cd ../frontend
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

---

## Usage
1. Open the Flutter app.
2. Enter your health data in the input fields.
3. Click the "Predict" button.
4. View the prediction result on the next page.

---

## Contributing
Contributions are welcome! If you'd like to contribute, please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeatureName`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeatureName`).
5. Open a pull request.

---

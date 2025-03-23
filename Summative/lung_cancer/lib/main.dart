import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // Controllers for each input field
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController smokingController = TextEditingController();
  final TextEditingController fingerDiscolorationController = TextEditingController();
  final TextEditingController mentalStressController = TextEditingController();
  final TextEditingController pollutionExposureController = TextEditingController();
  final TextEditingController longTermIllnessController = TextEditingController();
  final TextEditingController energyLevelController = TextEditingController();
  final TextEditingController immuneWeaknessController = TextEditingController();
  final TextEditingController breathingIssueController = TextEditingController();
  final TextEditingController alcoholConsumptionController = TextEditingController();
  final TextEditingController throatDiscomfortController = TextEditingController();
  final TextEditingController oxygenSaturationController = TextEditingController();
  final TextEditingController chestTightnessController = TextEditingController();
  final TextEditingController familyHistoryController = TextEditingController();
  final TextEditingController smokingFamilyHistoryController = TextEditingController();
  final TextEditingController stressImmuneController = TextEditingController();

  // Function to make the API request
  Future<void> predict() async {
    // API endpoint URL
    const String apiUrl = 'https://linear-regression-model-ntlf.onrender.com'; // Replace with your API URL

    // Prepare the input data
    Map<String, dynamic> inputData = {
      'AGE': int.parse(ageController.text),
      'GENDER': int.parse(genderController.text),
      'SMOKING': int.parse(smokingController.text),
      'FINGER_DISCOLORATION': int.parse(fingerDiscolorationController.text),
      'MENTAL_STRESS': int.parse(mentalStressController.text),
      'EXPOSURE_TO_POLLUTION': int.parse(pollutionExposureController.text),
      'LONG_TERM_ILLNESS': int.parse(longTermIllnessController.text),
      'ENERGY_LEVEL': double.parse(energyLevelController.text),
      'IMMUNE_WEAKNESS': int.parse(immuneWeaknessController.text),
      'BREATHING_ISSUE': int.parse(breathingIssueController.text),
      'ALCOHOL_CONSUMPTION': int.parse(alcoholConsumptionController.text),
      'THROAT_DISCOMFORT': int.parse(throatDiscomfortController.text),
      'OXYGEN_SATURATION': double.parse(oxygenSaturationController.text),
      'CHEST_TIGHTNESS': int.parse(chestTightnessController.text),
      'FAMILY_HISTORY': int.parse(familyHistoryController.text),
      'SMOKING_FAMILY_HISTORY': int.parse(smokingFamilyHistoryController.text),
      'STRESS_IMMUNE': int.parse(stressImmuneController.text),
    };

    // Make the POST request
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(inputData),
      );

      if (response.statusCode == 200) {
        // Parse the response
        Map<String, dynamic> result = json.decode(response.body);
        int prediction = result['prediction'];

        // Navigate to the result page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(prediction: prediction),
          ),
        );
      } else {
        // Handle errors
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(prediction: null, error: 'Error: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(prediction: null, error: 'Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction App'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields for each variable
            TextField(controller: ageController, decoration: InputDecoration(labelText: 'AGE')),
            TextField(controller: genderController, decoration: InputDecoration(labelText: 'GENDER')),
            TextField(controller: smokingController, decoration: InputDecoration(labelText: 'SMOKING')),
            TextField(controller: fingerDiscolorationController, decoration: InputDecoration(labelText: 'FINGER_DISCOLORATION')),
            TextField(controller: mentalStressController, decoration: InputDecoration(labelText: 'MENTAL_STRESS')),
            TextField(controller: pollutionExposureController, decoration: InputDecoration(labelText: 'EXPOSURE_TO_POLLUTION')),
            TextField(controller: longTermIllnessController, decoration: InputDecoration(labelText: 'LONG_TERM_ILLNESS')),
            TextField(controller: energyLevelController, decoration: InputDecoration(labelText: 'ENERGY_LEVEL')),
            TextField(controller: immuneWeaknessController, decoration: InputDecoration(labelText: 'IMMUNE_WEAKNESS')),
            TextField(controller: breathingIssueController, decoration: InputDecoration(labelText: 'BREATHING_ISSUE')),
            TextField(controller: alcoholConsumptionController, decoration: InputDecoration(labelText: 'ALCOHOL_CONSUMPTION')),
            TextField(controller: throatDiscomfortController, decoration: InputDecoration(labelText: 'THROAT_DISCOMFORT')),
            TextField(controller: oxygenSaturationController, decoration: InputDecoration(labelText: 'OXYGEN_SATURATION')),
            TextField(controller: chestTightnessController, decoration: InputDecoration(labelText: 'CHEST_TIGHTNESS')),
            TextField(controller: familyHistoryController, decoration: InputDecoration(labelText: 'FAMILY_HISTORY')),
            TextField(controller: smokingFamilyHistoryController, decoration: InputDecoration(labelText: 'SMOKING_FAMILY_HISTORY')),
            TextField(controller: stressImmuneController, decoration: InputDecoration(labelText: 'STRESS_IMMUNE')),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: predict,
              child: Text('Predict'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int? prediction;
  final String? error;

  ResultPage({this.prediction, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction Result'),
      ),
      body: Center(
        child: prediction != null
            ? Text('Prediction: $prediction')
            : Text(error ?? 'An error occurred'),
      ),
    );
  }
}
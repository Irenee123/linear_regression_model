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
      debugShowCheckedModeBanner: false,
      title: 'Health Prediction',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    "AGE": 0,
    "GENDER": 0,
    "SMOKING": 0,
    "FINGER_DISCOLORATION": 0,
    "MENTAL_STRESS": 0,
    "EXPOSURE_TO_POLLUTION": 0,
    "LONG_TERM_ILLNESS": 0,
    "ENERGY_LEVEL": 0.0,
    "IMMUNE_WEAKNESS": 0,
    "BREATHING_ISSUE": 0,
    "ALCOHOL_CONSUMPTION": 0,
    "THROAT_DISCOMFORT": 0,
    "OXYGEN_SATURATION": 0.0,
    "CHEST_TIGHTNESS": 0,
    "FAMILY_HISTORY": 0,
    "SMOKING_FAMILY_HISTORY": 0,
    "STRESS_IMMUNE": 0,
  };
  String _predictionResult = "";

  Future<void> _predict() async {
    final url = Uri.parse("https://linear-regression-model-ntlf.onrender.com/predict");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(_formData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _predictionResult = "Prediction: ${responseData['prediction']}";
        });
      } else {
        setState(() {
          _predictionResult = "Error: ${response.reasonPhrase}";
        });
      }
    } catch (error) {
      setState(() {
        _predictionResult = "Failed to connect to API";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Health Prediction')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                for (var key in _formData.keys)
                  TextFormField(
                    decoration: InputDecoration(labelText: key.replaceAll('_', ' ')),
                    keyboardType: key == "ENERGY_LEVEL" || key == "OXYGEN_SATURATION"
                        ? TextInputType.numberWithOptions(decimal: true)
                        : TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _formData[key] = key == "ENERGY_LEVEL" || key == "OXYGEN_SATURATION"
                            ? double.tryParse(value) ?? 0.0
                            : int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _predict,
                  child: Text('Predict'),
                ),
                SizedBox(height: 20),
                Text(
                  _predictionResult,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(prediction: responseData['prediction'].toString()),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(prediction: "Error: ${response.reasonPhrase}"),
          ),
        );
      }
    } catch (error) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(prediction: "Failed to connect to API"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lung Cancer Predictor')),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String prediction;
  
  ResultScreen({required this.prediction});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prediction Result')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prediction,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

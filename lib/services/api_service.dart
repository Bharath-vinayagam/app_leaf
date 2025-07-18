import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "http://10.126.101.156:8000";
  static const String _predictEndpoint = "/predict";

  static Future<String> predictDisease(File image) async {
    try {
      final request = http.MultipartRequest(
        'POST', 
        Uri.parse('$_baseUrl$_predictEndpoint')
      );
      
      request.files.add(
        await http.MultipartFile.fromPath('file', image.path)
      );

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (responseBody.statusCode == 200) {
        final data = json.decode(responseBody.body);
        return data['prediction'] ?? 'Unknown';
      } else {
        throw Exception('Prediction failed: ${responseBody.statusCode} - ${responseBody.body}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static String _getMockPrediction() {
    final diseases = [
      'Healthy Leaf',
      'Early Blight',
      'Late Blight',
      'Leaf Spot Disease',
      'Powdery Mildew',
      'Bacterial Spot',
      'Yellow Leaf Curl Virus',
    ];
    
    // Return a random disease for demo
    final random = DateTime.now().millisecond % diseases.length;
    return diseases[random];
  }

  static Future<Map<String, dynamic>> getDiseaseInfo(String diseaseName) async {
    // Mock disease information
    final diseaseInfo = {
      'Early Blight': {
        'description': 'A fungal disease that affects tomato and potato plants',
        'symptoms': [
          'Dark brown spots with concentric rings',
          'Yellowing of leaves',
          'Premature leaf drop'
        ],
        'treatments': [
          'Remove infected leaves',
          'Apply fungicide',
          'Improve air circulation',
          'Avoid overhead watering'
        ],
        'prevention': [
          'Crop rotation',
          'Proper spacing',
          'Mulching',
          'Regular monitoring'
        ]
      },
      'Late Blight': {
        'description': 'A serious disease that can destroy entire crops',
        'symptoms': [
          'Water-soaked lesions',
          'White fungal growth',
          'Rapid plant death'
        ],
        'treatments': [
          'Immediate removal of infected plants',
          'Copper-based fungicides',
          'Systemic fungicides'
        ],
        'prevention': [
          'Resistant varieties',
          'Good drainage',
          'Regular fungicide application'
        ]
      },
      'Healthy Leaf': {
        'description': 'Your plant appears to be healthy',
        'symptoms': ['No visible symptoms'],
        'treatments': ['Continue current care routine'],
        'prevention': [
          'Regular watering',
          'Proper fertilization',
          'Monitor for pests',
          'Good air circulation'
        ]
      }
    };

    return diseaseInfo[diseaseName] ?? {
      'description': 'Disease information not available',
      'symptoms': ['Unknown symptoms'],
      'treatments': ['Consult a plant expert'],
      'prevention': ['Regular monitoring']
    };
  }
} 
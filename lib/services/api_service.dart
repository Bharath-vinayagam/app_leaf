import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔗 Base URL of your FastAPI backend
  // ⚠️ Replace with your laptop's IP when testing on real device
  // Android emulator -> "http://10.0.2.2:8000"
  // iOS simulator   -> "http://127.0.0.1:8000"
  // Physical device -> "http://<YOUR_LAPTOP_IP>:8000"
  static const String _baseUrl = "http://10.126.101.156:8000";
  static const String _predictEndpoint = "/predict";

  /// Upload image to backend for disease prediction
  static Future<Map<String, dynamic>> predictDisease(File image) async {
    try {
      print('🌐 Sending image to backend: $_baseUrl$_predictEndpoint');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_baseUrl$_predictEndpoint'),
      );

      // ✅ FIXED: Backend expects "file", not "image"
      request.files.add(
        await http.MultipartFile.fromPath('file', image.path),
      );

      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      print('📡 Response status: ${responseBody.statusCode}');
      print('📄 Response body: ${responseBody.body}');

      if (responseBody.statusCode == 200) {
        final data = json.decode(responseBody.body);
        print('🔍 Parsed data: $data');

        return {
          'prediction': data['class'] ?? 'Unknown',
          'confidence': data['confidence'],
        };
      } else {
        print('❌ API Error: ${responseBody.statusCode} - ${responseBody.body}');
        throw Exception('Prediction failed: ${responseBody.statusCode} - ${responseBody.body}');
      }
    } catch (e) {
      print('💥 Network error: $e');

      // Fallback to mock data for testing
      print('🔄 Using fallback mock data');
      return {
        'prediction': _getMockPrediction(),
        'confidence': 0.85,
      };
    }
  }

  /// Mock prediction for offline testing
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

    final random = DateTime.now().millisecond % diseases.length;
    return diseases[random];
  }

  // 🧑‍🌾 Disease information (local + OpenAI fallback)
  static const String _openAIApiKey = 'YOUR_OPENAI_API_KEY';

  static Future<Map<String, dynamic>> getDiseaseInfo(String diseaseName) async {
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

    if (diseaseInfo.containsKey(diseaseName)) {
      return diseaseInfo[diseaseName]!;
    } else {
      return await _fetchDiseaseInfoFromOpenAI(diseaseName);
    }
  }

  /// Fetch extra disease info using OpenAI (fallback)
  static Future<Map<String, dynamic>> _fetchDiseaseInfoFromOpenAI(String diseaseName) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final prompt =
        'Provide a short description, a list of 3-5 symptoms, a list of 3-5 treatments, and a list of 3-5 prevention tips for the plant disease "$diseaseName". Respond in JSON with keys: description, symptoms, treatments, prevention.';

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_openAIApiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful plant pathology assistant.'},
          {'role': 'user', 'content': prompt},
        ],
        'max_tokens': 500,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final content = data['choices'][0]['message']['content'];

      try {
        final info = json.decode(content);
        return {
          'description': info['description'] ?? 'No description available.',
          'symptoms': List<String>.from(info['symptoms'] ?? []),
          'treatments': List<String>.from(info['treatments'] ?? []),
          'prevention': List<String>.from(info['prevention'] ?? []),
        };
      } catch (e) {
        return {
          'description': 'No detailed information available for $diseaseName.',
          'symptoms': ['Unknown symptoms'],
          'treatments': ['Consult a plant expert'],
          'prevention': ['Regular monitoring'],
        };
      }
    } else {
      return {
        'description': 'No detailed information available for $diseaseName.',
        'symptoms': ['Unknown symptoms'],
        'treatments': ['Consult a plant expert'],
        'prevention': ['Regular monitoring'],
      };
    }
  }
}

import 'dart:io';

class DiseaseDetection {
  final String id;
  final File image;
  final String diseaseName;
  final double confidence;
  final DateTime timestamp;
  final String? location;
  final List<String> symptoms;
  final List<String> treatments;
  final bool isHealthy;

  DiseaseDetection({
    required this.id,
    required this.image,
    required this.diseaseName,
    required this.confidence,
    required this.timestamp,
    this.location,
    required this.symptoms,
    required this.treatments,
    required this.isHealthy,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': image.path,
      'diseaseName': diseaseName,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
      'location': location,
      'symptoms': symptoms,
      'treatments': treatments,
      'isHealthy': isHealthy,
    };
  }

  factory DiseaseDetection.fromJson(Map<String, dynamic> json) {
    return DiseaseDetection(
      id: json['id'],
      image: File(json['imagePath']),
      diseaseName: json['diseaseName'],
      confidence: json['confidence'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      location: json['location'],
      symptoms: List<String>.from(json['symptoms']),
      treatments: List<String>.from(json['treatments']),
      isHealthy: json['isHealthy'],
    );
  }
} 
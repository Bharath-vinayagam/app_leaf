import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../providers/disease_history_provider.dart';
import '../services/api_service.dart';
import '../models/disease_detection.dart';
import '../widgets/image_preview_card.dart';
import '../widgets/feature_card.dart';
import 'camera_screen.dart';
import 'result_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _detectDisease() async {
    if (_selectedImage == null) return;

    setState(() => _isLoading = true);

    try {
      print('🔍 Starting disease detection...');
      
      // Get prediction and confidence from backend
      final predictionResult = await ApiService.predictDisease(_selectedImage!);
      print('📊 Raw prediction result: $predictionResult');
      
      // predictionResult should be a Map<String, dynamic> with 'prediction' and 'confidence'
      final prediction = predictionResult['prediction'] ?? 'Unknown';
      var confidenceRaw = predictionResult['confidence'];
      
      print('🏷️ Prediction: $prediction');
      print('📈 Raw confidence: $confidenceRaw (type: ${confidenceRaw.runtimeType})');
      
      double? confidence;
      if (confidenceRaw is double) {
        confidence = confidenceRaw;
      } else if (confidenceRaw is int) {
        confidence = confidenceRaw.toDouble();
      } else if (confidenceRaw is String) {
        confidence = double.tryParse(confidenceRaw);
      }
      
      print('🎯 Processed confidence: $confidence');
      
      if (confidence == null) throw Exception('No confidence score from backend');
      
      // Normalize confidence to 0-1 range if it's in percentage (0-100)
      if (confidence > 1.0) {
        confidence = confidence / 100.0;
        print('🔄 Normalized confidence from percentage: $confidence');
      }

      // Get symptoms, treatments, isHealthy from about page (getDiseaseInfo)
      final diseaseInfo = await ApiService.getDiseaseInfo(prediction);
      final symptoms = List<String>.from(diseaseInfo['symptoms'] ?? []);
      final treatments = List<String>.from(diseaseInfo['treatments'] ?? []);
      final isHealthy = prediction.toLowerCase().contains('healthy');
      
      print('🌿 Disease info loaded - Healthy: $isHealthy');

      // Create detection object
      final detection = DiseaseDetection(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        image: _selectedImage!,
        diseaseName: prediction,
        confidence: confidence,
        timestamp: DateTime.now(),
        symptoms: symptoms,
        treatments: treatments,
        isHealthy: isHealthy,
      );
      
      print('✅ Detection object created: ${detection.diseaseName} (${detection.confidence})');

      // Add to history
      context.read<DiseaseHistoryProvider>().addDetection(detection);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(detection: detection),
        ),
      );
    } catch (e) {
      print('💥 Error in disease detection: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearImage() {
    setState(() => _selectedImage = null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? AppTheme.cyberGradient : AppTheme.neonGradient,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.glassmorphismDark.color : AppTheme.glassmorphismLight.color,
                  borderRadius: BorderRadius.circular(24),
                  border: isDark ? AppTheme.glassmorphismDark.border : AppTheme.glassmorphismLight.border,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppTheme.neonGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.neonGradient.colors.first.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.eco_rounded,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Leaf Disease Detector',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'AI-Powered Plant Health Analysis',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDark ? Colors.white.withOpacity(0.8) : Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.3),

              const SizedBox(height: 24),

              // Image Selection Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.glassmorphismDark.color : AppTheme.glassmorphismLight.color,
                  borderRadius: BorderRadius.circular(24),
                  border: isDark ? AppTheme.glassmorphismDark.border : AppTheme.glassmorphismLight.border,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload Plant Image',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    
                    if (_selectedImage != null) ...[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.neonGradient.colors.first.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _isLoading ? null : () => _detectDisease(),
                              icon: _isLoading 
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.search_rounded),
                              label: Text(_isLoading ? 'Analyzing...' : 'Detect Disease'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.neonGradient.colors.first,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: _clearImage,
                            icon: const Icon(Icons.clear_rounded),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.1),
                              foregroundColor: Colors.red,
                              padding: const EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1),
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_rounded,
                              size: 48,
                              color: isDark ? Colors.white.withOpacity(0.6) : Colors.black54,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Select an image to analyze',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark ? Colors.white.withOpacity(0.6) : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.camera),
                              icon: const Icon(Icons.camera_alt_rounded),
                              label: const Text('Camera'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.neonGradient.colors.first,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo_library_rounded),
                              label: const Text('Gallery'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.neonGradient.colors[1],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3),

              const SizedBox(height: 24),

              // Features Section
              Text(
                'Features',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.psychology_rounded,
                      title: 'AI Analysis',
                      subtitle: 'Advanced machine learning for accurate disease detection',
                      color: AppTheme.neonGradient.colors[0],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.speed_rounded,
                      title: 'Fast Results',
                      subtitle: 'Get instant analysis in seconds',
                      color: AppTheme.neonGradient.colors[1],
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3),

              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.healing_rounded,
                      title: 'Treatment Tips',
                      subtitle: 'Get personalized treatment recommendations',
                      color: AppTheme.neonGradient.colors[2],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.history_rounded,
                      title: 'History',
                      subtitle: 'Track your plant health over time',
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3),
            ],
          ),
        ),
      ),
    );
  }
} 
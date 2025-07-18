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
      final prediction = await ApiService.predictDisease(_selectedImage!);
      
      // Create detection object
      final detection = DiseaseDetection(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        image: _selectedImage!,
        diseaseName: prediction,
        confidence: 0.85, // Mock confidence score
        timestamp: DateTime.now(),
        symptoms: ['Yellow spots', 'Wilting leaves'],
        treatments: ['Remove affected leaves', 'Apply fungicide'],
        isHealthy: prediction.toLowerCase().contains('healthy'),
      );

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
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 171, 218, 215), Color.fromARGB(255, 73, 136, 100)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    children: [
                      Icon(
                        Icons.eco,
                        size: 54,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Detect Plant Diseases',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Upload a photo of a plant leaf to identify diseases and get treatment recommendations',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
              const SizedBox(height: 28),
              if (_selectedImage != null) ...[
                ImagePreviewCard(
                  image: _selectedImage!,
                  onClear: _clearImage,
                ).animate().fadeIn(duration: 500.ms).scale(),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _detectDisease,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.search),
                  label: Text(_isLoading ? 'Predicting...' : 'Predict'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 18),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CameraScreen()),
                        );
                        if (result != null && result is File) {
                          setState(() => _selectedImage = result);
                        }
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
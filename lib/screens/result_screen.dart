import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/disease_detection.dart';
import '../providers/disease_history_provider.dart';
import '../services/api_service.dart';
import '../widgets/confidence_chart.dart';
import '../widgets/treatment_card.dart';

class ResultScreen extends StatefulWidget {
  final DiseaseDetection detection;

  const ResultScreen({
    super.key,
    required this.detection,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, dynamic>? _diseaseInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDiseaseInfo();
  }

  Future<void> _loadDiseaseInfo() async {
    try {
      final info = await ApiService.getDiseaseInfo(widget.detection.diseaseName);
      setState(() {
        _diseaseInfo = info;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final historyProvider = context.read<DiseaseHistoryProvider>();
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              widget.detection.isHealthy ? Icons.eco : Icons.warning_amber_rounded,
              color: widget.detection.isHealthy ? Colors.green : Colors.orange,
              size: 28,
            ),
            const SizedBox(width: 10),
            const Text('Detection Result'),
          ],
        ),
        elevation: 4,
        backgroundColor: Colors.white.withOpacity(0.95),
        foregroundColor: widget.detection.isHealthy ? Colors.green.shade900 : Colors.orange.shade900,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image and Basic Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              widget.detection.image,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.detection.diseaseName,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.detection.isHealthy 
                                  ? Colors.green 
                                  : Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Detected on ${_formatDate(widget.detection.timestamp)}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: -0.2),

                  const SizedBox(height: 16),

                  // Confidence Score
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confidence Score',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ConfidenceChart(confidence: widget.detection.confidence),
                        ],
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2),

                  const SizedBox(height: 16),

                  // Disease Information
                  if (_diseaseInfo != null) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _diseaseInfo!['description'],
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn().slideY(begin: 0.3),

                    const SizedBox(height: 16),

                    // Symptoms
                    TreatmentCard(
                      title: 'Symptoms',
                      icon: Icons.warning,
                      items: _diseaseInfo!['symptoms'],
                      color: Colors.orange,
                    ).animate().fadeIn().slideY(begin: 0.4),

                    const SizedBox(height: 16),

                    // Treatments
                    TreatmentCard(
                      title: 'Treatment',
                      icon: Icons.healing,
                      items: _diseaseInfo!['treatments'],
                      color: Colors.green,
                    ).animate().fadeIn().slideY(begin: 0.5),

                    const SizedBox(height: 16),

                    // Prevention
                    TreatmentCard(
                      title: 'Prevention',
                      icon: Icons.shield,
                      items: _diseaseInfo!['prevention'],
                      color: Colors.blue,
                    ).animate().fadeIn().slideY(begin: 0.6),
                  ],

                  const SizedBox(height: 24),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            historyProvider.toggleFavorite(widget.detection);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  historyProvider.favorites.contains(widget.detection)
                                      ? 'Added to favorites'
                                      : 'Removed from favorites',
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            historyProvider.favorites.contains(widget.detection)
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: const Text('Favorite'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement share functionality
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideY(begin: 0.7),
                ],
              ),
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
} 
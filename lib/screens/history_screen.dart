import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/disease_history_provider.dart';
import '../models/disease_detection.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.history, color: Colors.white),
              const SizedBox(width: 10),
              const Text('Detection History'),
            ],
          ),
          elevation: 4,
          backgroundColor: const Color(0xFF047857),
          foregroundColor: Colors.white,
          bottom: TabBar(
            labelColor: theme.colorScheme.onPrimary,
            unselectedLabelColor: theme.colorScheme.onPrimary.withOpacity(0.7),
            indicatorColor: theme.colorScheme.secondary,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _HistoryList(detections: context.watch<DiseaseHistoryProvider>().detections),
            _HistoryList(detections: context.watch<DiseaseHistoryProvider>().favorites),
          ],
        ),
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  final List<DiseaseDetection> detections;

  const _HistoryList({required this.detections});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (detections.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No detections yet',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start by detecting a disease to see it here',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: detections.length,
      itemBuilder: (context, index) {
        final detection = detections[index];
        final isHealthy = detection.isHealthy;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            shadowColor: isHealthy ? Colors.green.shade100 : Colors.orange.shade100,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(detection: detection),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        detection.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isHealthy ? Icons.eco : Icons.warning_amber_rounded,
                                color: isHealthy ? Colors.green : Colors.orange,
                                size: 22,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  detection.diseaseName,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: isHealthy ? Colors.green.shade800 : Colors.orange.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(detection.confidence * 100).round()}% confidence',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(detection.timestamp),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        context.read<DiseaseHistoryProvider>().favorites.contains(detection)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context.read<DiseaseHistoryProvider>().toggleFavorite(detection);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
} 
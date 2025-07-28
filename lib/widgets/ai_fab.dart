import 'package:flutter/material.dart';
import '../screens/ai_chat_screen.dart';

class AIFab extends StatelessWidget {
  const AIFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.smart_toy),
      label: const Text('AI'),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AIChatScreen()),
        );
      },
      heroTag: 'ai-fab',
    );
  }
} 
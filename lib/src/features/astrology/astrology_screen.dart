
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AstrologyScreen extends StatelessWidget {
  const AstrologyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astrology Reading'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Discover your cosmic message.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/astrology/result'),
              child: const Text('Draw Three Cards'),
            ),
          ],
        ),
      ),
    );
  }
}

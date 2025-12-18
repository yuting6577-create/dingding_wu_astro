
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TarotScreen extends StatelessWidget {
  const TarotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarot Reading'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your spread',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/tarot/single'),
              child: const Text('Draw a Single Card'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/tarot/three-card'),
              child: const Text('Three-Card Spread'),
            ),
          ],
        ),
      ),
    );
  }
}

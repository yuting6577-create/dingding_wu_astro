
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'application/tarot_service.dart';
import 'models/tarot_card.dart';

class TarotResultScreen extends StatefulWidget {
  final String spreadType;

  const TarotResultScreen({super.key, required this.spreadType});

  @override
  State<TarotResultScreen> createState() => _TarotResultScreenState();
}

class _TarotResultScreenState extends State<TarotResultScreen> {
  final TarotService _tarotService = TarotService();
  late List<Map<String, dynamic>> _drawnCards;

  @override
  void initState() {
    super.initState();
    _drawCards();
  }

  void _drawCards() {
    setState(() {
      if (widget.spreadType == 'single') {
        _drawnCards = [_tarotService.drawSingleCard()];
      } else {
        _drawnCards = _tarotService.drawThreeCardSpread();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Tarot Reading'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ..._drawnCards.map((cardData) {
              final TarotCard card = cardData['card'];
              final bool isReversed = cardData['isReversed'];
              return _buildCard(card, isReversed, context);
            }),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _drawCards,
              child: const Text('Draw Again'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/tarot'),
              child: const Text('Back to Spreads'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(TarotCard card, bool isReversed, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              card.name + (isReversed ? ' (Reversed)' : ''),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            // Placeholder for the image
            Icon(Icons.image, size: 150, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              isReversed ? card.reversedMeaning : card.uprightMeaning,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

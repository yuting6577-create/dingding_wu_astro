
import 'package:flutter/material.dart';

import 'application/astrology_service.dart';
import 'models/zodiac_card.dart';
import 'models/planet_card.dart';
import 'models/house_card.dart';

class AstrologyResultScreen extends StatefulWidget {
  const AstrologyResultScreen({super.key});

  @override
  State<AstrologyResultScreen> createState() => _AstrologyResultScreenState();
}

class _AstrologyResultScreenState extends State<AstrologyResultScreen> {
  final AstrologyService _astrologyService = AstrologyService();
  late Map<String, dynamic> _drawnCards;

  @override
  void initState() {
    super.initState();
    _drawCards();
  }

  void _drawCards() {
    setState(() {
      _drawnCards = _astrologyService.drawThreeCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ZodiacCard zodiacCard = _drawnCards['zodiac'];
    final PlanetCard planetCard = _drawnCards['planet'];
    final HouseCard houseCard = _drawnCards['house'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cosmic Reading'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCard('Zodiac', zodiacCard.name, context),
            const SizedBox(height: 20),
            _buildCard('Planet', planetCard.name, context),
            const SizedBox(height: 20),
            _buildCard('House', houseCard.name, context),
            const SizedBox(height: 40),
            Text(
              'Combined Interpretation',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text(
              'This is a placeholder for the combined interpretation of the three cards. It will provide a holistic message based on the interaction of the zodiac sign, the planet, and the house.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _drawCards,
              child: const Text('Draw Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String cardName, BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              cardName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

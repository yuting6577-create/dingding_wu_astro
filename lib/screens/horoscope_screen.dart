
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HoroscopeScreen extends StatelessWidget {
  const HoroscopeScreen({super.key});

  final List<String> zodiacSigns = const [
    'Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 'Libra',
    'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Horoscope'),
      ),
      body: ListView.builder(
        itemCount: zodiacSigns.length,
        itemBuilder: (context, index) {
          final sign = zodiacSigns[index];
          return ListTile(
            title: Text(sign),
            onTap: () => context.go('/horoscope/$sign'),
          );
        },
      ),
    );
  }
}

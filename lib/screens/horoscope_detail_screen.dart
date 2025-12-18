
import 'package:flutter/material.dart';

class HoroscopeDetailScreen extends StatelessWidget {
  const HoroscopeDetailScreen({super.key, required this.sign});

  final String sign;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sign),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Here is the daily horoscope for $sign. This is placeholder text and will be replaced with real data later.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


import 'dart:math';

import '../data/tarot_deck.dart';
import '../models/tarot_card.dart';

class TarotService {
  final Random _random = Random();

  // Draws a single random tarot card.
  Map<String, dynamic> drawSingleCard() {
    final card = tarotDeck[_random.nextInt(tarotDeck.length)];
    final isReversed = _random.nextBool();
    return {
      'card': card,
      'isReversed': isReversed,
    };
  }

  // Draws a three-card spread (e.g., Past, Present, Future).
  List<Map<String, dynamic>> drawThreeCardSpread() {
    final List<TarotCard> shuffledDeck = List.from(tarotDeck)..shuffle(_random);
    final List<Map<String, dynamic>> spread = [];

    for (int i = 0; i < 3; i++) {
      final card = shuffledDeck[i];
      final isReversed = _random.nextBool();
      spread.add({
        'card': card,
        'isReversed': isReversed,
      });
    }
    return spread;
  }
}

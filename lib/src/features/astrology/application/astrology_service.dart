
import 'dart:math';

import '../data/zodiac_deck.dart';
import '../data/planet_deck.dart';
import '../data/house_deck.dart';
import '../models/zodiac_card.dart';
import '../models/planet_card.dart';
import '../models/house_card.dart';

class AstrologyService {
  final Random _random = Random();

  ZodiacCard drawZodiacCard() {
    return zodiacDeck[_random.nextInt(zodiacDeck.length)];
  }

  PlanetCard drawPlanetCard() {
    return planetDeck[_random.nextInt(planetDeck.length)];
  }

  HouseCard drawHouseCard() {
    return houseDeck[_random.nextInt(houseDeck.length)];
  }

  Map<String, dynamic> drawThreeCards() {
    return {
      'zodiac': drawZodiacCard(),
      'planet': drawPlanetCard(),
      'house': drawHouseCard(),
    };
  }
}

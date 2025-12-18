
import '../models/tarot_card.dart';

final List<TarotCard> tarotDeck = [
  // Major Arcana
  TarotCard(
    name: 'The Fool',
    uprightMeaning: 'Beginnings, innocence, spontaneity, a free spirit',
    reversedMeaning: 'Naivety, foolishness, recklessness, risk-taking',
    imagePath: 'assets/images/tarot/the_fool.png',
    isMajorArcana: true,
  ),
  TarotCard(
    name: 'The Magician',
    uprightMeaning: 'Manifestation, resourcefulness, power, inspired action',
    reversedMeaning: 'Manipulation, poor planning, untapped talents',
    imagePath: 'assets/images/tarot/the_magician.png',
    isMajorArcana: true,
  ),
  // ... more Major Arcana cards

  // Minor Arcana - Wands
  TarotCard(
    name: 'Ace of Wands',
    uprightMeaning: 'Inspiration, new opportunities, growth, potential',
    reversedMeaning: 'An emerging idea, a lack of direction, distractions, delays',
    imagePath: 'assets/images/tarot/ace_of_wands.png',
    isMajorArcana: false,
  ),
  // ... more Wands cards

  // Minor Arcana - Cups
  TarotCard(
    name: 'Ace of Cups',
    uprightMeaning: 'Love, new relationships, compassion, creativity',
    reversedMeaning: 'Self-love, intuition, repressed emotions',
    imagePath: 'assets/images/tarot/ace_of_cups.png',
    isMajorArcana: false,
  ),
  // ... more Cups cards

  // Minor Arcana - Swords
  TarotCard(
    name: 'Ace of Swords',
    uprightMeaning: 'Breakthroughs, new ideas, mental clarity, success',
    reversedMeaning: 'Inner clarity, re-thinking an idea, clouded judgement',
    imagePath: 'assets/images/tarot/ace_of_swords.png',
    isMajorArcana: false,
  ),
  // ... more Swords cards

  // Minor Arcana - Pentacles
  TarotCard(
    name: 'Ace of Pentacles',
    uprightMeaning: 'A new financial or career opportunity, manifestation, abundance',
    reversedMeaning: 'Lost opportunity, lack of planning, excessive spending',
    imagePath: 'assets/images/tarot/ace_of_pentacles.png',
    isMajorArcana: false,
  ),
  // ... and so on for all 78 cards.
];

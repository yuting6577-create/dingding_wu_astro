
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:go_router/go_router.dart';

class TarotDailyScreen extends StatefulWidget {
  const TarotDailyScreen({super.key});

  @override
  _TarotDailyScreenState createState() => _TarotDailyScreenState();
}

class _TarotDailyScreenState extends State<TarotDailyScreen> {
  List<Map<String, dynamic>>? drawnCards;
  bool isLoading = false;

  Future<void> _drawCards() async {
    setState(() {
      isLoading = true;
    });

    final random = Random();
    final tarotCollection = FirebaseFirestore.instance.collection('tarot_cards');
    final allCardsSnapshot = await tarotCollection.get();
    final allCards = allCardsSnapshot.docs;
    
    final Set<int> drawnIndices = {};
    final List<Map<String, dynamic>> tempDrawnCards = [];

    while (tempDrawnCards.length < 3 && drawnIndices.length < allCards.length) {
      final randomIndex = random.nextInt(allCards.length);
      if (!drawnIndices.contains(randomIndex)) {
        drawnIndices.add(randomIndex);
        final cardData = allCards[randomIndex].data();
        cardData['isReversed'] = random.nextBool(); // Determine if the card is reversed
        tempDrawnCards.add(cardData);
      }
    }

    setState(() {
      drawnCards = tempDrawnCards;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('每日塔羅'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : drawnCards == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: _drawCards,
                    child: const Text('抽三張牌'),
                  ),
                )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: drawnCards!.length,
                        itemBuilder: (context, index) {
                          final card = drawnCards![index];
                          final bool isReversed = card['isReversed'] ?? false;
                          final String name = card['name_zh'] ?? '未知牌';
                          final String displayText = isReversed 
                              ? card['reversedText_zh'] ?? '逆位解釋不存在' 
                              : card['uprightText_zh'] ?? '正位解釋不存在';
                    
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('$name (${isReversed ? '逆位' : '正位'})', style: Theme.of(context).textTheme.headline6),
                                  const SizedBox(height: 8),
                                  Text(displayText),
                                  const SizedBox(height: 12),
                                  Text('愛情建議: ${card['love'] ?? 'N/A'}'),
                                  Text('事業建議: ${card['career'] ?? 'N/A'}'),
                                  Text('財務建議: ${card['finance'] ?? 'N/A'}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: ElevatedButton(onPressed: _drawCards, child: const Text('重新抽牌')),
                   ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50), // Make button wider
                      ),
                      onPressed: () => context.go('/season-spread'),
                      child: const Text('探索年度稀缺：四季牌陣指引'),
                    ),
                  )
                ],
              ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class AstrologyTrinityDrawScreen extends StatefulWidget {
  const AstrologyTrinityDrawScreen({super.key});

  @override
  _AstrologyTrinityDrawScreenState createState() => _AstrologyTrinityDrawScreenState();
}

class _AstrologyTrinityDrawScreenState extends State<AstrologyTrinityDrawScreen> {
  Map<String, dynamic>? planetCard;
  Map<String, dynamic>? houseCard;
  Map<String, dynamic>? signCard;
  bool isLoading = false;

  Future<void> _drawCards() async {
    setState(() {
      isLoading = true;
    });

    final random = Random();

    // Fetch all documents from each collection
    final planetsFuture = FirebaseFirestore.instance.collection('planets').get();
    final housesFuture = FirebaseFirestore.instance.collection('houses').get();
    final signsFuture = FirebaseFirestore.instance.collection('signs').get();

    final results = await Future.wait([planetsFuture, housesFuture, signsFuture]);

    final planets = results[0].docs;
    final houses = results[1].docs;
    final signs = results[2].docs;

    // Select a random card from each list
    final randomPlanet = planets[random.nextInt(planets.length)].data();
    final randomHouse = houses[random.nextInt(houses.length)].data();
    final randomSign = signs[random.nextInt(signs.length)].data();

    setState(() {
      planetCard = randomPlanet;
      houseCard = randomHouse;
      signCard = randomSign;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('占星三星牌'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: (planetCard != null) ? () { /* Share functionality */ } : null,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : planetCard == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: _drawCards,
                    child: const Text('抽三星牌'),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCard('行星', planetCard!['name_zh'] ?? 'N/A'),
                          _buildCard('宮位', houseCard!['name_zh'] ?? 'N/A'),
                          _buildCard('星座', signCard!['name_zh'] ?? 'N/A'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '"${planetCard!['name_zh']}" 在 "${houseCard!['name_zh']}"，以 "${signCard!['name_zh']}" 的方式呈現。',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      _buildDescription('行星解讀', planetCard!['full_description_zh'] ?? '', planetCard!['advice_zh'] ?? ''),
                      _buildDescription('宮位解讀', houseCard!['full_description_zh'] ?? '', houseCard!['advice_zh'] ?? ''),
                      _buildDescription('星座解讀', signCard!['full_description_zh'] ?? '', signCard!['advice_zh'] ?? ''),
                      const SizedBox(height: 20),
                      ElevatedButton(onPressed: _drawCards, child: const Text('重新抽牌')),

                    ],
                  ),
                ),
    );
  }

  Widget _buildCard(String title, String name) {
    return Card(
      elevation: 4,
      child: Container(
        width: 100,
        height: 150,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.subtitle2),
            const SizedBox(height: 8),
            Text(name, style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(String title, String description, String advice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(description),
        const SizedBox(height: 8),
         Text('建議: $advice', style: const TextStyle(fontWeight: FontWeight.bold)),
        const Divider(height: 32),
      ],
    );
  }
}


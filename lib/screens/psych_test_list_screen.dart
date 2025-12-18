
import 'package:flutter/material.dart';

class PsychTestListScreen extends StatefulWidget {
  const PsychTestListScreen({super.key});

  @override
  State<PsychTestListScreen> createState() => _PsychTestListScreenState();
}

class _PsychTestListScreenState extends State<PsychTestListScreen> {
  String? _resultText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('心理測驗'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '你覺得哪種情況最讓你感到焦慮？',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resultText = '你傾向於過度思考，試著活在當下。';
                });
              },
              child: const Text('公開演講'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resultText = '你重視人際關係，但有時會感到社交壓力。';
                });
              },
              child: const Text('參加一個全是陌生人的派對'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resultText = '你追求完美，對自己有很高的要求。';
                });
              },
              child: const Text('重要的考試或面試'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _resultText = '你渴望穩定，但也要學會擁抱不確定性。';
                });
              },
              child: const Text('對未來的規劃感到迷惘'),
            ),
            const SizedBox(height: 30),
            if (_resultText != null)
              Card(
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        _resultText!,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          // Share functionality to be implemented
                        },
                        tooltip: '分享結果',
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

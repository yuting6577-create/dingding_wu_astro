
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// 1. 定義 TestModel
class TestModel {
  final String question;
  final List<String> options;
  final List<String> results;

  TestModel({required this.question, required this.options, required this.results})
      : assert(options.length == 4 && results.length == 4);
}

class PsychTestListScreen extends StatefulWidget {
  const PsychTestListScreen({super.key});

  @override
  State<PsychTestListScreen> createState() => _PsychTestListScreenState();
}

class _PsychTestListScreenState extends State<PsychTestListScreen> {
  // 2. 建立 TestModel 實例 (未來可以從 Firestore 載入)
  final TestModel _currentTest = TestModel(
    question: '你覺得哪種情況最讓你感到焦慮？',
    options: [
      '公開演講',
      '參加一個全是陌生人的派對',
      '重要的考試或面試',
      '對未來的規劃感到迷惘',
    ],
    results: [
      '結果A：你傾向於過度思考，試著活在當下。',
      '結果B：你重視人際關係，但有時會感到社交壓力。',
      '結果C：你追求完美，對自己有很高的要求。',
      '結果D：你渴望穩定，但也要學會擁抱不確定性。',
    ],
  );

  String? _resultText;

  void _handleOptionPressed(int index) {
    setState(() {
      _resultText = _currentTest.results[index];
    });
  }
  // 3. 實現分享功能
  void _shareResult() {
    if (_resultText != null) {
      Share.share('我在「鼎鼎無名的占卜小館」的心理測驗結果是：$_resultText');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('心理測驗'),
        actions: [
          if (_resultText != null)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareResult,
              tooltip: '分享結果',
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _currentTest.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 使用 ListView.builder 動態生成按鈕
            ...List.generate(
              _currentTest.options.length,
              (index) => ElevatedButton(
                onPressed: () => _handleOptionPressed(index),
                child: Text(_currentTest.options[index]),
              ),
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
                        onPressed: _shareResult,
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

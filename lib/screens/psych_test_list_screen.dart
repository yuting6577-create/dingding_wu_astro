
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';

// 1. 定義 TestModel
class TestModel {
  final String category;
  final String question;
  final List<dynamic> options;
  final List<dynamic> results;

  TestModel({
    required this.category,
    required this.question,
    required this.options,
    required this.results,
  });

  factory TestModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TestModel(
      category: data['category'] ?? '',
      question: data['question'] ?? '',
      options: data['options'] ?? [],
      results: data['results'] ?? [],
    );
  }
}

class PsychTestListScreen extends StatelessWidget {
  const PsychTestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('心理測驗'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('psych_tests').orderBy('number').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('錯誤：${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final tests = snapshot.data!.docs.map((doc) => TestModel.fromFirestore(doc)).toList();

          return PageView.builder(
            itemCount: tests.length,
            itemBuilder: (context, index) {
              return PsychTestPage(test: tests[index]);
            },
          );
        },
      ),
    );
  }
}

class PsychTestPage extends StatefulWidget {
  final TestModel test;

  const PsychTestPage({super.key, required this.test});

  @override
  _PsychTestPageState createState() => _PsychTestPageState();
}

class _PsychTestPageState extends State<PsychTestPage> {
  String? _resultText;

  void _handleOptionPressed(int index) {
    setState(() {
      _resultText = widget.test.results[index];
    });
  }

  void _shareResult() {
    if (_resultText != null) {
      Share.share('我在「鼎鼎無名的占卜小館」的心理測驗結果是：$_resultText');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.test.category,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            widget.test.question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            widget.test.options.length,
            (index) => ElevatedButton(
              onPressed: () => _handleOptionPressed(index),
              child: Text(widget.test.options[index].toString()),
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
    );
  }
}

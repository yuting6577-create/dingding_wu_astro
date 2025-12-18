
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizResultScreen extends StatefulWidget {
  final String? quizId;

  const QuizResultScreen({super.key, this.quizId});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  int? _selectedOptionIndex;
  Future<DocumentSnapshot>? _quizFuture;

  @override
  void initState() {
    super.initState();
    if (widget.quizId != null) {
      _quizFuture = FirebaseFirestore.instance
          .collection('psychology_tests')
          .doc(widget.quizId)
          .get();
    }
  }

  void _shareResult(Map<String, dynamic> quizData, int resultIndex) {
    final results = quizData['results'] as List<dynamic>;
    final result = results[resultIndex];
    final shareText = quizData['share_text'] as String? ?? '';
    final options = quizData['options'] as List<dynamic>;

    final textToShare = '"${quizData['question']}"\n'
        '我選的是：${options[resultIndex]}\n\n'
        '結果是：${result['title']}\n'
        '${result['content']}\n\n'
        '$shareText';

    Share.share(textToShare);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.quizId == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('找不到測驗ID，請返回上一頁'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedOptionIndex == null ? '請選擇' : '測驗結果',
          style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.tertiaryContainer,
            ],
          ),
        ),
        child: FutureBuilder<DocumentSnapshot>(
          future: _quizFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('找不到測驗資料'));
            }

            final quizData = snapshot.data!.data() as Map<String, dynamic>;

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _selectedOptionIndex == null
                  ? _buildOptionsView(context, quizData)
                  : _buildResultView(context, quizData, _selectedOptionIndex!),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOptionsView(BuildContext context, Map<String, dynamic> quizData) {
    final question = quizData['question'] as String;
    final options = (quizData['options'] as List<dynamic>).cast<String>();

    return Center(
      key: const ValueKey('options'),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 40),
            ...List.generate(options.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedOptionIndex = index;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                  ),
                  child: Text(
                    options[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView(
      BuildContext context, Map<String, dynamic> quizData, int resultIndex) {
    final results = quizData['results'] as List<dynamic>;
    final result = results[resultIndex];

    return Center(
      key: const ValueKey('result'),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      result['title']!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      result['content']!,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        height: 1.6,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: const Text('重測一次'),
                  onPressed: () {
                    setState(() {
                      _selectedOptionIndex = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('分享結果'),
                  onPressed: () {
                    _shareResult(quizData, resultIndex);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

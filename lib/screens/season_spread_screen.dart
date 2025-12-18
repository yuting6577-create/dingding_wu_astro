
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SeasonSpreadScreen extends StatelessWidget {
  const SeasonSpreadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('四季牌陣'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '四季牌陣為您提供年度運勢的深度洞察。\n\n此為專業諮詢服務，請聯繫我們的認證塔羅師進行一對一的預約抽牌與解讀。\n\n- 中央核心 (Major Arcana)\n- 左方上升 (Wands)\n- 下方天底 (Cups)\n- 右方下降 (Swords)\n- 上方天頂 (Pentacles)',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse('https://your-booking-link.com')); // Replace with your actual booking link
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('聯繫老師預約抽牌', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}


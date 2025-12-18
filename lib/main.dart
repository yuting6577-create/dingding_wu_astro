
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';
import 'screens/psych_test_list_screen.dart';
import 'screens/astrology_trinity_draw_screen.dart';
import 'screens/tarot_daily_screen.dart';
import 'screens/vip_service_screen.dart';
import 'screens/season_spread_screen.dart';
import 'src/widgets/scaffold_with_nested_navigation.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/psych-test',
      builder: (context, state) => const PsychTestListScreen(),
    ),
    GoRoute(
      path: '/astrology-trinity',
      builder: (context, state) => const AstrologyTrinityDrawScreen(),
    ),
    GoRoute(
      path: '/tarot-daily',
      builder: (context, state) => const TarotDailyScreen(),
    ),
    GoRoute(
      path: '/vip-service',
      builder: (context, state) => const VipServiceScreen(),
    ),
    GoRoute(
      path: '/season-spread',
      builder: (context, state) => const SeasonSpreadScreen(),
    ),
  ],
);

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    developer.log('====== UNCAUGHT FLUTTER ERROR ======', error: error, stackTrace: stack);
  });
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark; // Force dark mode

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    // Keeping this in case you want to re-enable theme toggling
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.deepPurple;
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      )
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          routerConfig: _router,
          title: 'Star-Diviner',
          theme: darkTheme, // Force dark theme
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('24 小時在線陪伴'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildHomeCard(
                    context,
                    title: '心理測驗',
                    onTap: () => context.go('/psych-test'),
                  ),
                  const SizedBox(height: 16),
                  _buildHomeCard(
                    context,
                    title: '占星牌卡 (三星牌)',
                    buttonText: '抽三星牌',
                    onTap: () => context.go('/astrology-trinity'),
                  ),
                  const SizedBox(height: 16),
                  _buildHomeCard(
                    context,
                    title: '塔羅占卜',
                    onTap: () => context.go('/tarot-daily'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.star),
              label: const Text('VIP 深度解析'),
              onPressed: () => context.go('/vip-service'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.headset_mic),
              label: const Text('專人諮詢預約'),
              onPressed: () {
                // Replace with your external booking link
                launchUrl(Uri.parse('https://your-booking-link.com'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCard(BuildContext context, {required String title, String? buttonText, required VoidCallback onTap}) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              if (buttonText != null) ...[
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onTap,
                  child: Text(buttonText),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

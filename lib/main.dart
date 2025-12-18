
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'src/features/home/home_screen.dart';
import 'src/features/astrology/astrology_screen.dart';
import 'src/features/astrology/astrology_result_screen.dart';
import 'src/features/tarot/tarot_screen.dart';
import 'src/features/tarot/tarot_result_screen.dart';
import 'src/features/quiz/quiz_screen.dart';
import 'src/features/quiz/quiz_result_screen.dart';
import 'src/widgets/scaffold_with_nested_navigation.dart';
import 'screens/horoscope_screen.dart';
import 'screens/horoscope_detail_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/quiz',
              builder: (context, state) => const QuizScreen(),
              routes: [
                GoRoute(
                  path: 'result/:quizId',
                  builder: (context, state) {
                    final quizId = state.pathParameters['quizId'];
                    return QuizResultScreen(quizId: quizId);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/astrology',
              builder: (context, state) => const AstrologyScreen(),
              routes: [
                GoRoute(
                  path: 'result',
                  builder: (context, state) => const AstrologyResultScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tarot',
              builder: (context, state) => const TarotScreen(),
              routes: [
                GoRoute(
                  path: 'single',
                  builder: (context, state) =>
                      const TarotResultScreen(spreadType: 'single'),
                ),
                GoRoute(
                  path: 'three-card',
                  builder: (context, state) =>
                      const TarotResultScreen(spreadType: 'three-card'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/horoscope',
              builder: (context, state) => const HoroscopeScreen(),
              routes: [
                GoRoute(
                  path: ':sign',
                  builder: (context, state) {
                    final String sign = state.pathParameters['sign']!;
                    return HoroscopeDetailScreen(sign: sign);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
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
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

    void setSystemTheme() {
    _themeMode = ThemeMode.system;
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

    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
    );

    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          routerConfig: _router,
          title: 'Star-Diviner',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
        );
      },
    );
  }
}

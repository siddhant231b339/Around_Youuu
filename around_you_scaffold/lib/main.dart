import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'theme/app_theme.dart';
import 'providers/providers.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/auth/auth_screen.dart';
import 'ui/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const ProviderScope(child: ARoundYouApp()));
}

class ARoundYouApp extends ConsumerWidget {
  const ARoundYouApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final authState = ref.watch(authStateChangesProvider);

    return MaterialApp(
      title: 'ARound You',
      debugShowCheckedModeBanner: false,
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: ThemeMode.dark,
      home: authState.when(
        data: (user) {
          if (user == null) return const AuthScreen();
          return const HomeScreen();
        },
        loading: () => const SplashScreen(),
        error: (_, __) => const AuthScreen(),
      ),
    );
  }
}
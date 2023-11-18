import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_app/config/routes_generator.dart';
import 'package:skeleton_app/config/theme.dart';

import 'features/authentication/data/datasources/local_datasource.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _init();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // override the previous value with the new object
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (_) => RouteGenerator.kTitle,
      theme: theme,
      initialRoute: RouteGenerator.kSplashPage,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
    );
  }
}

Future<void> _init() async {
  _setupLogging();
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

import 'package:flutter/material.dart';

// Core imports
import 'core/theme/app_theme.dart';

// Screen imports
import 'presentation/screens/home_screen.dart';

/// Main App Widget
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}

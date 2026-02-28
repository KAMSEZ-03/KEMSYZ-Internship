import 'package:flutter/material.dart';
import 'app.dart'; // equivalent of App.tsx

void main() {
  runApp(const MyAppRoot());
}

/// Root wrapper (like React root render)
class MyAppRoot extends StatelessWidget {
  const MyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return const App(); // same as <App />
  }
}

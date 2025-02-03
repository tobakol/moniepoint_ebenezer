import 'package:flutter/material.dart';

import 'resources/theme/light_theme.dart';
import 'views/tab_bar/tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoniePoint Dribble Assessment',
      theme: lightTheme(),
      home: NavBar(),
    );
  }
}

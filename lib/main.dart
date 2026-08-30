import 'package:flutter/material.dart';
import 'package:taxawu/pages/welcome.dart';
import 'package:taxawu/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TAXAWU',
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
    );
  }
}

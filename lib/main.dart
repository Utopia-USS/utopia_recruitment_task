import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/auth_page/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(UtopiaApp());
}

class UtopiaApp extends StatelessWidget {
  const UtopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utopia App',
      theme: CustomTheme.lightTheme,
      home: AuthPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: CustomTheme.pagePadding,
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: CustomTheme.lightBlue,
              ),
              SizedBox(height: 36.0),
              Text(
                'Welcome to Utopia',
                style: TextStyle(
                  color: CustomTheme.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

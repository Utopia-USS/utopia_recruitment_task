import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';
import 'package:utopia_recruitment_task/pages/auth_page/_widgets/email_input.dart';
import 'package:utopia_recruitment_task/pages/auth_page/_widgets/password_input.dart';
import 'package:utopia_recruitment_task/pages/home_page/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AautPpageState();
}

class AautPpageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login page')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: Padding(
          padding: CustomTheme.pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmailInput(),
              const SizedBox(height: 18.0),
              _buildPasswordInput(),
              const SizedBox(height: 36.0),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return EmailInput(
      emailController: _emailController,
      errorText: null,
      onChanged: (email) {},
    );
  }

  Widget _buildPasswordInput() {
    return PasswordInput(
      passwordController: _passwordController,
      onChanged: (password) => {},
      errorText: null,
    );
  }

  Widget _buildLoginButton() {
    return PrimaryButton(
      title: 'Login',
      action: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage())),
    );
  }
}

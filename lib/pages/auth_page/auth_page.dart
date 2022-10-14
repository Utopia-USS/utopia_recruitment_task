import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:utopia_recruitment_task/blocs/signin_cubit/signin_cubit.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_button.dart';
import 'package:utopia_recruitment_task/pages/_widgets/buttons/primary_loading_button.dart';
import 'package:utopia_recruitment_task/pages/_widgets/custom_messenger.dart';
import 'package:utopia_recruitment_task/pages/auth_page/_widgets/email_input.dart';
import 'package:utopia_recruitment_task/pages/auth_page/_widgets/password_input.dart';
import 'package:utopia_recruitment_task/pages/home_page/home_page.dart';
import 'package:utopia_recruitment_task/service/auth_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: AuthPage());

  @override
  State<AuthPage> createState() => AautPpageState();
}

class AautPpageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SignInCubit _signInCubit;

  @override
  void initState() {
    super.initState();
    _signInCubit = SignInCubit(context.read<AuthService>());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login page')),
      body: Container(
        decoration: BoxDecoration(
          gradient: CustomTheme.pageGradient,
        ),
        child: Padding(
          padding: CustomTheme.contentPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmailInput(),
              const SizedBox(height: CustomTheme.spacing),
              _buildPasswordInput(),
              const SizedBox(height: CustomTheme.spacing * 3),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (_, state) {
        return EmailInput(
          emailController: _emailController,
          errorText: state.email.invalid ? 'Invalid email' : null,
          onChanged: (email) => _signInCubit.emailChanged(email),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return BlocBuilder<SignInCubit, SignInState>(
      bloc: _signInCubit,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (_, state) {
        return PasswordInput(
          passwordController: _passwordController,
          onChanged: (password) => _signInCubit.passwordChanged(password),
          errorText: state.password.invalid ? 'Invalid password' : null,
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return BlocConsumer<SignInCubit, SignInState>(
      bloc: _signInCubit,
      listener: ((_, state) {
        if (state.status == FormzStatus.submissionSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false);
        } else if (state.status == FormzStatus.submissionFailure) {
          CustomMessager().showError(
            context: context,
            message: state.errorMessage ?? 'Ooops!',
          );
        }
      }),
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        if (state.status == FormzStatus.submissionInProgress ||
            state.status == FormzStatus.submissionSuccess) {
          return const PrimaryLoadingButton();
        } else {
          return PrimaryButton(
            title: 'Login',
            action: () => _signInCubit.logInWithCredentials(),
          );
        }
      },
    );
  }
}

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
import 'package:utopia_recruitment_task/pages/auth_page/_widgets/password_tips.dart';
import 'package:utopia_recruitment_task/pages/home_page/home_page.dart';
import 'package:utopia_recruitment_task/service/auth_service.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: CustomTheme.contentPadding,
            child: BlocProvider(
              create: (_) => SignInCubit(
                context.read<AuthService>(),
              ),
              child: const _AuthPageView(),
            ),
          ),
        ),
      );
}

class _AuthPageView extends StatelessWidget {
  const _AuthPageView();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'LOGIN',
            style: CustomTheme.appBarTitle,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: CustomTheme.pageGradient,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: CustomTheme.contentPadding,
                child: Container(
                  padding: CustomTheme.contentPadding,
                  decoration: const BoxDecoration(
                    color: CustomTheme.white,
                    borderRadius: CustomTheme.mainRadius,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _EmailInput(),
                      const SizedBox(height: CustomTheme.spacing),
                      _PasswordInput(),
                      const SizedBox(height: CustomTheme.spacing),
                      const _PasswordTips(),
                      _LogInButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (_, state) => EmailInput(
          errorText: state.email.invalid ? 'Invalid email' : null,
          onChanged: (String email) =>
              context.read<SignInCubit>().emailChanged(email),
        ),
      );
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<SignInCubit, SignInState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) => PasswordInput(
          errorText: state.password.invalid ? 'Invalid password' : null,
          onChanged: (String password) =>
              context.read<SignInCubit>().passwordChanged(password),
        ),
      );
}

class _PasswordTips extends StatelessWidget {
  const _PasswordTips();

  @override
  Widget build(BuildContext context) => BlocBuilder<SignInCubit, SignInState>(
        builder: (_, state) {
          if (state.password.status == FormzInputStatus.invalid) {
            return const Padding(
              padding: EdgeInsets.only(bottom: CustomTheme.spacing),
              child: PasswordTips(),
            );
          } else {
            return Container();
          }
        },
      );
}

class _LogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocConsumer<SignInCubit, SignInState>(
        listener: (_, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          } else if (state.status == FormzStatus.submissionFailure) {
            CustomMessager().showError(
              context: context,
              message: state.errorMessage ?? 'Ooops!',
            );
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (_, state) {
          if (state.status == FormzStatus.submissionInProgress ||
              state.status == FormzStatus.submissionSuccess) {
            return const PrimaryLoadingButton();
          } else {
            return PrimaryButton(
              title: 'Login',
              onPressed: context.read<SignInCubit>().logInWithCredentials,
            );
          }
        },
      );
}

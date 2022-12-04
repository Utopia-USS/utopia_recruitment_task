import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/blocs/bloc_observer.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/splash_page/splash_page.dart';
import 'package:utopia_recruitment_task/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();

  await Firebase.initializeApp();

  final authService = AuthService();

  runApp(UtopiaApp(authService: authService));
}

class UtopiaApp extends StatelessWidget {
  const UtopiaApp({
    super.key,
    required AuthService authService,
  }) : _authService = authService;

  final AuthService _authService;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: _authService,
        child: BlocProvider(
          create: (_) => AppBloc(
            authService: _authService,
          ),
          child: const AppView(),
        ),
      );
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.light,
        home: const SplashPage(),
      );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/pages/splash_page/splash_page.dart';
import 'package:utopia_recruitment_task/service/auth_service.dart';

import '../firebase_mock.dart';

class MockAuthService extends Mock implements AuthService {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

void main() async {
  setupFirebaseAuthMocks();

  const splashPageKey = Key('splashPageKey');

  group('SplashPage.', () {
    late MockAuthService authService;
    late AppBloc appBloc;

    setUp(() async {
      await Firebase.initializeApp();
      authService = MockAuthService();
      appBloc = MockAppBloc();
      when(() => appBloc.state).thenReturn(const AppState.unauthenticated());
    });

    testWidgets('finds SplashPage widgets.', (WidgetTester tester) async {
      await tester.pumpWidget(
        RepositoryProvider<AuthService>(
          create: (_) => authService,
          child: BlocProvider(
            create: (context) => appBloc,
            child: const MaterialApp(
              home: SplashPage(key: splashPageKey),
            ),
          ),
        ),
      );

      expect(find.byKey(splashPageKey), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('WELCOME'), findsOneWidget);
    });
  });
}

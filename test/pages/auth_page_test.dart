// // import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_firebase_login/login/login.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:utopia_recruitment_task/blocs/signin_cubit/signin_cubit.dart';
// import 'package:utopia_recruitment_task/models/email_model.dart';
// import 'package:utopia_recruitment_task/models/password_model.dart';
// import 'package:utopia_recruitment_task/pages/auth_page/auth_page.dart';
// import 'package:utopia_recruitment_task/service/auth_service.dart';

// class MockAuthService extends Mock implements AuthService {}

// class MockLoginCubit extends MockCubit<SignInState> implements SignInCubit {}

// class MockEmail extends Mock implements Email {}

// class MockPassword extends Mock implements Password {}

// void main() {
//   const emailInputKey = Key('emailInputKey');
//   const passwordInputKey = Key('passwordInputKey');
//   const loginButtonKey = Key('primaryLoadingButtonKey');
//   // const primaryLoadingButtonKey = Key('primaryLoadingButtonKey');

//   group('AuthPage', () {
//     test('has a page', () {
//       expect(AuthPage.page(), isA<MaterialPage<void>>());
//     });

//     //   testWidgets('renders an AuthPage', (tester) async {
//     //     await tester.pumpWidget(
//     //       RepositoryProvider<AuthService>(
//     //         create: (_) => MockAuthService(),
//     //         child: const MaterialApp(home: AuthPage()),
//     //       ),
//     //     );
//     //     expect(find.byKey(emailInputKey), findsOneWidget);
//     //     expect(find.byKey(passwordInputKey), findsOneWidget);
//     //     expect(find.byKey(loginButtonKey), findsOneWidget);
//     //     // expect(find.byKey(primaryLoadingButtonKey), findsNothing);
//     //   });
//     // });
// // }

//     group('LoginForm', () {
//       late SignInCubit signInCubit;

//       setUp(() {
//         signInCubit = MockLoginCubit();
//         when(() => signInCubit.state).thenReturn(const SignInState());
//         when(() => signInCubit.logInWithCredentials()).thenAnswer((_) async {});
//       });

//       group('calls', () {
//         testWidgets('emailChanged when email changes', (tester) async {
//           await tester.pumpWidget(
//             MaterialApp(
//               home: Scaffold(
//                 body: BlocProvider.value(
//                   value: signInCubit,
//                   child: const AuthPage(),
//                 ),
//               ),
//             ),
//           );
//           await tester.enterText(find.byKey(emailInputKey), "testEmail");
//           verify(() => signInCubit.emailChanged("testEmail")).called(1);
//         });

//         // testWidgets('passwordChanged when password changes', (tester) async {
//         //   await tester.pumpWidget(
//         //     MaterialApp(
//         //       home: Scaffold(
//         //         body: BlocProvider.value(
//         //           value: signInCubit,
//         //           child: const LoginForm(),
//         //         ),
//         //       ),
//         //     ),
//         //   );
//         //   await tester.enterText(find.byKey(passwordInputKey), testPassword);
//         //   verify(() => signInCubit.passwordChanged(testPassword)).called(1);
//         // });

//         // testWidgets('logInWithCredentials when login button is pressed',
//         //     (tester) async {
//         //   when(() => signInCubit.state).thenReturn(
//         //     const SignInState(status: FormzStatus.valid),
//         //   );
//         //   await tester.pumpWidget(
//         //     MaterialApp(
//         //       home: Scaffold(
//         //         body: BlocProvider.value(
//         //           value: signInCubit,
//         //           child: const LoginForm(),
//         //         ),
//         //       ),
//         //     ),
//         //   );
//         //   await tester.tap(find.byKey(loginButtonKey));
//         //   verify(() => signInCubit.logInWithCredentials()).called(1);
//         // });

//         // testWidgets('logInWithGoogle when sign in with google button is pressed',
//         //     (tester) async {
//         //   await tester.pumpWidget(
//         //     MaterialApp(
//         //       home: Scaffold(
//         //         body: BlocProvider.value(
//         //           value: signInCubit,
//         //           child: const LoginForm(),
//         //         ),
//         //       ),
//         //     ),
//         //   );
//         //   await tester.tap(find.byKey(signInWithGoogleButtonKey));
//         //   verify(() => signInCubit.logInWithGoogle()).called(1);
//         // });
//       });

//       // group('renders', () {
//       //   testWidgets('AuthenticationFailure SnackBar when submission fails',
//       //       (tester) async {
//       //     whenListen(
//       //       signInCubit,
//       //       Stream.fromIterable(const <SignInState>[
//       //         SignInState(status: FormzStatus.submissionInProgress),
//       //         SignInState(status: FormzStatus.submissionFailure),
//       //       ]),
//       //     );
//       //     await tester.pumpWidget(
//       //       MaterialApp(
//       //         home: Scaffold(
//       //           body: BlocProvider.value(
//       //             value: signInCubit,
//       //             child: const LoginForm(),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     await tester.pump();
//       //     expect(find.text('Authentication Failure'), findsOneWidget);
//       //   });

//       //   testWidgets('invalid email error text when email is invalid',
//       //       (tester) async {
//       //     final email = MockEmail();
//       //     when(() => email.invalid).thenReturn(true);
//       //     when(() => signInCubit.state).thenReturn(SignInState(email: email));
//       //     await tester.pumpWidget(
//       //       MaterialApp(
//       //         home: Scaffold(
//       //           body: BlocProvider.value(
//       //             value: signInCubit,
//       //             child: const LoginForm(),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     expect(find.text('invalid email'), findsOneWidget);
//       //   });

//       //   testWidgets('invalid password error text when password is invalid',
//       //       (tester) async {
//       //     final password = MockPassword();
//       //     when(() => password.invalid).thenReturn(true);
//       //     when(() => signInCubit.state).thenReturn(SignInState(password: password));
//       //     await tester.pumpWidget(
//       //       MaterialApp(
//       //         home: Scaffold(
//       //           body: BlocProvider.value(
//       //             value: signInCubit,
//       //             child: const LoginForm(),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     expect(find.text('invalid password'), findsOneWidget);
//       //   });

//       //   testWidgets('disabled login button when status is not validated',
//       //       (tester) async {
//       //     when(() => signInCubit.state).thenReturn(
//       //       const SignInState(status: FormzStatus.invalid),
//       //     );
//       //     await tester.pumpWidget(
//       //       MaterialApp(
//       //         home: Scaffold(
//       //           body: BlocProvider.value(
//       //             value: signInCubit,
//       //             child: const LoginForm(),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     final loginButton = tester.widget<ElevatedButton>(
//       //       find.byKey(loginButtonKey),
//       //     );
//       //     expect(loginButton.enabled, isFalse);
//       //   });

//       //   testWidgets('enabled login button when status is validated',
//       //       (tester) async {
//       //     when(() => signInCubit.state).thenReturn(
//       //       const SignInState(status: FormzStatus.valid),
//       //     );
//       //     await tester.pumpWidget(
//       //       MaterialApp(
//       //         home: Scaffold(
//       //           body: BlocProvider.value(
//       //             value: signInCubit,
//       //             child: const LoginForm(),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     final loginButton = tester.widget<ElevatedButton>(
//       //       find.byKey(loginButtonKey),
//       //     );
//       //     expect(loginButton.enabled, isTrue);
//       //   });

//       //   testWidgets('Sign in with Google Button', (tester) async {
//       //     await tester.pumpWidget(
//       //       MaterialApp(
//       //         home: Scaffold(
//       //           body: BlocProvider.value(
//       //             value: signInCubit,
//       //             child: const LoginForm(),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     expect(find.byKey(signInWithGoogleButtonKey), findsOneWidget);
//       //   });
//       // });

//       // group('navigates', () {
//       //   testWidgets('to SignUpPage when Create Account is pressed',
//       //       (tester) async {
//       //     await tester.pumpWidget(
//       //       RepositoryProvider<AuthenticationRepository>(
//       //         create: (_) => MockAuthenticationRepository(),
//       //         child: MaterialApp(
//       //           home: Scaffold(
//       //             body: BlocProvider.value(
//       //               value: signInCubit,
//       //               child: const LoginForm(),
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     );
//       //     await tester.tap(find.byKey(createAccountButtonKey));
//       //     await tester.pumpAndSettle();
//       //     expect(find.byType(SignUpPage), findsOneWidget);
//       //   });
//       // });
//     });
//   });
// }

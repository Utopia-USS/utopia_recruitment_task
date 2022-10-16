// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_recruitment_task/helpers/formz/password_input.dart';

void main() {
  const validPasswordString = 'mockPassword123!';
  const invalidPasswordString = 'mockPassword';

  group('Password', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final password = Password.pure();
        expect(password.value, '');
        expect(password.pure, true);
      });

      test('dirty creates correct instance', () {
        final password = Password.dirty(validPasswordString);
        expect(password.value, validPasswordString);
        expect(password.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when password is empty', () {
        expect(
          Password.dirty().error,
          PasswordValidationError.invalid,
        );
      });

      test('is valid when password is not empty', () {
        expect(
          Password.dirty(validPasswordString).error,
          isNull,
        );
      });

      test('is invalid when password is not invalid', () {
        expect(
          Password.dirty(invalidPasswordString).error,
          isNotNull,
        );
      });
    });
  });
}

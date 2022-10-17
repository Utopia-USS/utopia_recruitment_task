// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_recruitment_task/helpers/formz/email_input.dart';

import '../constants.dart';

void main() {
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final email = Email.pure();
        expect(email.value, '');
        expect(email.pure, true);
      });

      test('dirty creates correct instance', () {
        final email = Email.dirty(validEmailString);
        expect(email.value, validEmailString);
        expect(email.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when email is empty', () {
        expect(
          Email.dirty().error,
          EmailValidationError.invalid,
        );
      });

      test('is valid when email is not empty', () {
        expect(
          Email.dirty(validEmailString).error,
          isNull,
        );
      });

      test('is invalid when email is not valid', () {
        expect(
          Email.dirty(invalidEmailString).error,
          isNotNull,
        );
      });
    });
  });
}

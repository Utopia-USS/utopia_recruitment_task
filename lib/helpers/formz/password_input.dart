import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  /// r'^
  /// (?=.*[A-Z])       should contain at least one upper case
  /// (?=.*[a-z])       should contain at least one lower case
  /// (?=.*?[0-9])      should contain at least one digit
  /// (?=.*?[!@#\$&*~]) should contain at least one Special character
  /// .{8,}             Must be at least 8 characters in length
  /// $'

  static final _passwordRegExp =
      RegExp(r'^(?=.*[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}

import 'package:formz/formz.dart';

enum LinkValidationError { invalid }

class URL extends FormzInput<String, LinkValidationError> {
  const URL.pure() : super.pure('');
  const URL.dirty([super.value = '']) : super.dirty();

  static final _urlRegExp =
      RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

  @override
  LinkValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      return _urlRegExp.hasMatch(value) ? null : LinkValidationError.invalid;
    }
  }
}

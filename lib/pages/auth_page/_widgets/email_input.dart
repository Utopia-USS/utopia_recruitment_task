import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);
  final String? errorText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        key: const Key('emailInputKey'),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          errorText: errorText,
        ),
        onChanged: onChanged,
      );
}

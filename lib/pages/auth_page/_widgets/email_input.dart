import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;
  final String? errorText;
  final Function onChanged;
  final Function? onEditingComplete;

  const EmailInput({
    Key? key,
    required this.emailController,
    required this.errorText,
    required this.onChanged,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('emailInputKey'),
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: errorText,
      ),
      onChanged: (val) => onChanged(val),
      onEditingComplete: () =>
          onEditingComplete != null ? onEditingComplete!() : () => {},
    );
  }
}

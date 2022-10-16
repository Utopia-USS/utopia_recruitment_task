import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class PasswordTips extends StatelessWidget {
  const PasswordTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: CustomTheme.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Password should be:'),
          Text(" - at least one upper case"),
          Text(" - at least one lower case"),
          Text(" - at least one digit"),
          Text(" - minimum 8 symbols"),
        ],
      ),
    );
  }
}

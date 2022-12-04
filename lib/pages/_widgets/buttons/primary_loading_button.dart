import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class PrimaryLoadingButton extends StatelessWidget {
  const PrimaryLoadingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 55.0,
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              CustomTheme.darkBlue,
            ),
            overlayColor: MaterialStateProperty.all(
              CustomTheme.white.withOpacity(.2),
            ),
            foregroundColor: MaterialStateProperty.all(
              CustomTheme.white,
            ),
          ),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomTheme.white),
            strokeWidth: 2.5,
          ),
          onPressed: () {},
        ),
      );
}

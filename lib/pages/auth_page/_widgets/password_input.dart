import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utopia_recruitment_task/blocs/simlpe_switch_cubit/simlpe_switch_cubit.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController passwordController;
  final String? labelText;
  final String? errorText;
  final Function onChanged;

  const PasswordInput({
    Key? key,
    required this.passwordController,
    this.labelText,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final SimlpeSwitchCubit _simlpeSwitchCubit = SimlpeSwitchCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimlpeSwitchCubit, bool>(
      bloc: _simlpeSwitchCubit,
      builder: (_, state) {
        return TextFormField(
          controller: widget.passwordController,
          decoration: InputDecoration(
            labelText: widget.labelText ?? 'Password',
            errorText: widget.errorText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: GestureDetector(
              child: Container(
                width: 50.0,
                padding: const EdgeInsets.only(right: 8.0),
                color: Colors.transparent,
                child: Center(
                  child: FaIcon(
                    !state ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                    size: 20.0,
                    color: CustomTheme.darkBlue,
                  ),
                ),
              ),
              onTap: () => _simlpeSwitchCubit.onSwitch(),
            ),
          ),
          obscureText: _simlpeSwitchCubit.state,
          onChanged: (val) => widget.onChanged(val),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utopia_recruitment_task/blocs/simlpe_switch_cubit/simlpe_switch_cubit.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    this.labelText,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final String? labelText;
  final String? errorText;
  final void Function(String) onChanged;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final SimlpeSwitchCubit _simlpeSwitchCubit = SimlpeSwitchCubit();

  @override
  Widget build(BuildContext context) => BlocBuilder<SimlpeSwitchCubit, bool>(
        bloc: _simlpeSwitchCubit,
        builder: (_, state) => TextFormField(
          decoration: InputDecoration(
            labelText: widget.labelText ?? 'Password',
            errorText: widget.errorText,
            suffixIcon: GestureDetector(
              onTap: _simlpeSwitchCubit.onSwitch,
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
            ),
          ),
          obscureText: _simlpeSwitchCubit.state,
          onChanged: widget.onChanged,
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class ArrowIndicator extends StatefulWidget {
  const ArrowIndicator({Key? key}) : super(key: key);

  @override
  State<ArrowIndicator> createState() => _ArrowIndicatorState();
}

class _ArrowIndicatorState extends State<ArrowIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animation;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 50,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: 50.0,
        height: 100.0,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: _animation.value),
          child: const SizedBox(
            width: 50.0,
            height: 50.0,
            child: Icon(
              Icons.arrow_downward_rounded,
              color: CustomTheme.white,
              size: 36.0,
            ),
          ),
        ),
      );
}

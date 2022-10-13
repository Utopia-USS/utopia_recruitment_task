import 'package:flutter_bloc/flutter_bloc.dart';

class SimlpeSwitchCubit extends Cubit<bool> {
  SimlpeSwitchCubit() : super(true);

  void onSwitch() => emit(!state);
}

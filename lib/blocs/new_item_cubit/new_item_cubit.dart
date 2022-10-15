import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/models/name_model.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

part 'new_item_state.dart';

class NewItemCubit extends Cubit<NewItemState> {
  final FirebaseItemService _itemService;

  NewItemCubit(this._itemService) : super(const NewItemState());

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name]),
    ));
  }

  void noteChanged(String value) {
    emit(state.copyWith(
      note: value,
      status: Formz.validate([state.name]),
    ));
  }

  void urlChanged(String value) {
    emit(state.copyWith(
      url: value,
      status: Formz.validate([state.name]),
    ));
  }

  Future<void> addItem(String uid) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      final item = Item(
        DateTime.now(),
        state.name.value,
        state.note,
        state.url,
      );
      await _itemService.saveItem(uid, item);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

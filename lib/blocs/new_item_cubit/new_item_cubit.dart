import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/helpers/formz/url_input.dart';
import 'package:utopia_recruitment_task/helpers/formz/name_input.dart';
import 'package:utopia_recruitment_task/service/datetime_service.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

part 'new_item_state.dart';

class NewItemCubit extends Cubit<NewItemState> {
  final FirebaseItemService _itemService;
  final DateTimeService _datetimeService;

  NewItemCubit(
    this._itemService,
    this._datetimeService,
  ) : super(const NewItemState());

  void nameChanged(String value) {
    final name = Name.dirty(value);

    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.url,
      ]),
    ));
  }

  void noteChanged(String value) {
    emit(state.copyWith(
      note: value,
      status: Formz.validate([state.name, state.url]),
    ));
  }

  void urlChanged(String value) {
    final link = URL.dirty(value);
    emit(state.copyWith(
      url: link,
      status: Formz.validate([state.name, link]),
    ));
  }

  Future<void> addItem(String uid) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final item = Item(
        _datetimeService.now(),
        state.name.value,
        state.note,
        state.url.value,
      );
      await _itemService.saveItem(uid, item);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

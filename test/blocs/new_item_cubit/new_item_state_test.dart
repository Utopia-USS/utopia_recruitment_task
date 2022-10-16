// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:utopia_recruitment_task/blocs/new_item_cubit/new_item_cubit.dart';
import 'package:utopia_recruitment_task/helpers/formz/name_input.dart';
import 'package:utopia_recruitment_task/helpers/formz/url_input.dart';

void main() {
  const name = Name.dirty('name');
  const url = URL.dirty('https://github.com/ViktorKirjanov');

  group('NewItemState', () {
    test('supports value comparisons', () {
      expect(NewItemState(), NewItemState());
    });

    test('returns same object when no properties are passed', () {
      expect(NewItemState().copyWith(), NewItemState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        NewItemState().copyWith(status: FormzStatus.pure),
        NewItemState(),
      );
    });

    test('returns object with updated name when name is passed', () {
      expect(
        NewItemState().copyWith(name: name),
        NewItemState(name: name),
      );
    });

    test('returns object with updated url when url is passed', () {
      expect(
        NewItemState().copyWith(note: 'Lorem ipsum'),
        NewItemState(note: 'Lorem ipsum'),
      );
    });

    test('returns object with updated url when url is passed', () {
      expect(
        NewItemState().copyWith(url: url),
        NewItemState(url: url),
      );
    });
  });
}

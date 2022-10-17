// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:utopia_recruitment_task/blocs/new_item_cubit/new_item_cubit.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/service/datetime_service.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

import '../../constants.dart';

class MockFirebaseItemService extends Mock implements FirebaseItemService {}

class MockDateTimeService extends Mock implements DateTimeService {}

void main() {
  final item = Item(
    dateTime,
    validNameString,
    noteString,
    validURLString,
  );

  group('NewItemCubit', () {
    late FirebaseItemService itemService;
    late DateTimeService datetimeService;
    late NewItemCubit newItemCubit;

    setUp(() {
      itemService = MockFirebaseItemService();
      datetimeService = MockDateTimeService();
      newItemCubit = NewItemCubit(itemService, datetimeService);

      when(
        () => itemService.saveItem(uid, item),
      ).thenAnswer((_) async {});

      when(
        () => datetimeService.now(),
      ).thenAnswer((_) => dateTime);
    });

    test('initial state is NewItemState', () {
      expect(NewItemCubit(itemService, datetimeService).state, NewItemState());
    });

    group('nameChanged', () {
      blocTest<NewItemCubit, NewItemState>(
        'valid when name is set',
        build: () => newItemCubit,
        act: (cubit) => cubit.nameChanged(validNameString),
        expect: () => <NewItemState>[
          NewItemState(name: validName, status: FormzStatus.valid),
        ],
      );
    });

    group('noteChanged', () {
      blocTest<NewItemCubit, NewItemState>(
        'pure when name is empty',
        build: () => newItemCubit,
        act: (cubit) => cubit.noteChanged(noteString),
        expect: () => <NewItemState>[
          NewItemState(
            note: noteString,
            status: FormzStatus.pure,
          ),
        ],
      );

      blocTest<NewItemCubit, NewItemState>(
        'valid when name is not empty',
        build: () => newItemCubit,
        seed: () => NewItemState(name: validName),
        act: (cubit) => cubit.noteChanged(noteString),
        expect: () => <NewItemState>[
          NewItemState(
            name: validName,
            note: noteString,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('noteChanged', () {
      blocTest<NewItemCubit, NewItemState>(
        'invalid when url is invalid',
        build: () => newItemCubit,
        seed: () => NewItemState(name: validName),
        act: (cubit) => cubit.urlChanged(invalidURLString),
        expect: () => <NewItemState>[
          NewItemState(
            name: validName,
            url: invalidURL,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<NewItemCubit, NewItemState>(
        'valid when url is valid',
        build: () => newItemCubit,
        seed: () => NewItemState(name: validName),
        act: (cubit) => cubit.urlChanged(validURLString),
        expect: () => <NewItemState>[
          NewItemState(
            name: validName,
            url: validURL,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('addItem', () {
      blocTest<NewItemCubit, NewItemState>(
        'does nothing when status is not validated',
        build: () => newItemCubit,
        act: (cubit) => cubit.addItem('uid'),
        expect: () => <NewItemState>[],
      );

      blocTest<NewItemCubit, NewItemState>(
        'calls editComment with correct comment data',
        build: () => newItemCubit,
        seed: () => NewItemState(
          name: validName,
          note: noteString,
          url: validURL,
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.addItem(uid),
        verify: (_) {
          verify(
            () => itemService.saveItem(uid, item),
          ).called(1);
        },
      );

      blocTest<NewItemCubit, NewItemState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when addItem succeeds',
        build: () => newItemCubit,
        seed: () => NewItemState(
          name: validName,
          note: noteString,
          url: validURL,
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.addItem(uid),
        expect: () => <NewItemState>[
          NewItemState(
            name: validName,
            note: noteString,
            url: validURL,
            status: FormzStatus.submissionInProgress,
          ),
          NewItemState(
            name: validName,
            note: noteString,
            url: validURL,
            status: FormzStatus.submissionSuccess,
          )
        ],
      );

      blocTest<NewItemCubit, NewItemState>(
        'emits [submissionInProgress, submissionFailure] '
        'when addItem succeeds',
        build: () => newItemCubit,
        setUp: () {
          when(() => itemService.saveItem(uid, item)).thenThrow(Exception());
        },
        seed: () => NewItemState(
          name: validName,
          note: noteString,
          url: validURL,
          status: FormzStatus.valid,
        ),
        act: (cubit) => cubit.addItem(uid),
        expect: () => <NewItemState>[
          NewItemState(
            name: validName,
            note: noteString,
            url: validURL,
            status: FormzStatus.submissionInProgress,
          ),
          NewItemState(
            name: validName,
            note: noteString,
            url: validURL,
            status: FormzStatus.submissionFailure,
          )
        ],
      );
    });
  });
}

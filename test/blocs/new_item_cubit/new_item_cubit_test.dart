// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:utopia_recruitment_task/blocs/new_item_cubit/new_item_cubit.dart';
import 'package:utopia_recruitment_task/helpers/formz/name_input.dart';
import 'package:utopia_recruitment_task/helpers/formz/url_input.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/service/firebase_item_service.dart';

class MockFirebaseItemService extends Mock implements FirebaseItemService {}

void main() {
  const validNameString = 'item name';
  const validName = Name.dirty(validNameString);
  const validURLString = 'https://github.com/ViktorKirjanov';
  const validURL = URL.dirty(validURLString);
  const invalidURLString = 'xxx';
  const invalidURL = URL.dirty(invalidURLString);
  const noteString = 'Lorem ipsum ...';
  const uid = 'uid';
  final now = DateTime.now();

  // final milliseconds = now.toUtc().millisecondsSinceEpoch;
  // final createdWithoutMicroseconds = DateTime(
  //   now.year,
  //   now.month,
  //   now.day,
  //   now.hour,
  //   now.minute,
  //   now.second,
  //   now.millisecond,
  // );

  final item = Item(
    now,
    validNameString,
    noteString,
    validURLString,
  );

  group('NewItemCubit', () {
    late FirebaseItemService itemService;
    late NewItemCubit newItemCubit;

    setUp(() {
      itemService = MockFirebaseItemService();
      newItemCubit = NewItemCubit(itemService);

      when(
        () => itemService.saveItem(uid, item),
      ).thenAnswer((_) async {});
    });

    test('initial state is NewItemState', () {
      expect(NewItemCubit(itemService).state, NewItemState());
    });

    group('nameChanged', () {
      blocTest<NewItemCubit, NewItemState>(
        'valid when name is set',
        build: () => newItemCubit,
        act: (cubit) => cubit.nameChanged(validNameString),
        expect: () => const <NewItemState>[
          NewItemState(name: validName, status: FormzStatus.valid),
        ],
      );
    });

    group('noteChanged', () {
      blocTest<NewItemCubit, NewItemState>(
        'pure when name is empty',
        build: () => newItemCubit,
        act: (cubit) => cubit.noteChanged(noteString),
        expect: () => const <NewItemState>[
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
        expect: () => const <NewItemState>[
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
        expect: () => const <NewItemState>[
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
        expect: () => const <NewItemState>[
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
        expect: () => const <NewItemState>[],
      );

      // blocTest<NewItemCubit, NewItemState>(
      //   'Calls editComment with correct comment data',
      //   build: () => newItemCubit,
      //   seed: () => NewItemState(
      //     name: validName,
      //     note: noteString,
      //     url: validURL,
      //     status: FormzStatus.valid,
      //   ),
      //   act: (cubit) => cubit.addItem(uid),
      //   verify: (_) {
      //     verify(
      //       () => itemService.saveItem(uid, item),
      //     ).called(1);
      //   },
      // );

      // blocTest<NewItemCubit, NewItemState>(
      //   'emits [submissionInProgress, submissionSuccess] '
      //   'when addItem succeeds',
      //   build: () => newItemCubit,
      //   seed: () => NewItemState(
      //     name: validName,
      //     note: noteString,
      //     url: validURL,
      //     status: FormzStatus.valid,
      //   ),
      //   act: (cubit) => cubit.addItem(uid),
      //   expect: () => const <NewItemState>[
      //     NewItemState(
      //       name: validName,
      //       note: noteString,
      //       url: validURL,
      //       status: FormzStatus.submissionInProgress,
      //     ),
      //     NewItemState(
      //       name: validName,
      //       note: noteString,
      //       url: validURL,
      //       status: FormzStatus.submissionSuccess,
      //     )
      //   ],
      // );
    });
  });
}

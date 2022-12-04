import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';

void main() {
  group('Item', () {
    final created = DateTime.now();
    final milliseconds = created.toUtc().millisecondsSinceEpoch;
    final createdWithoutMicroseconds = DateTime(
      created.year,
      created.month,
      created.day,
      created.hour,
      created.minute,
      created.second,
      created.millisecond,
    );

    test('supports value comparison', () {
      expect(
        Item(
          created,
          'name',
          'note',
          'url',
        ),
        Item(
          created,
          'name',
          'note',
          'url',
        ),
      );
    });

    test('parse from snapshot', () async {
      final FakeFirebaseFirestore fakeFirebaseFirestore =
          FakeFirebaseFirestore();

      final Map<String, dynamic> data = {
        'created': milliseconds,
        'name': 'name',
        'note': 'note',
        'url': 'url',
      };

      await fakeFirebaseFirestore
          .collection('collectionPath')
          .doc('documentPath')
          .collection('items')
          .doc('123456')
          .set(data);

      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fakeFirebaseFirestore
              .collection('collectionPath')
              .doc('documentPath')
              .collection('items')
              .doc('123456')
              .get();

      expect(
        Item.fromSnapshot(documentSnapshot),
        Item(
          createdWithoutMicroseconds,
          'name',
          'note',
          'url',
        ),
      );
    });

    group('convert to json', () {
      test('all fields', () async {
        expect(
          Item(
            created,
            'name',
            'note',
            'url',
          ).toJson(),
          {
            'created': milliseconds,
            'name': 'name',
            'note': 'note',
            'url': 'url',
          },
        );
      });

      test('note and note are empty', () async {
        expect(
          Item(
            created,
            'name',
            '',
            '',
          ).toJson(),
          {
            'created': milliseconds,
            'name': 'name',
            'note': null,
            'url': null,
          },
        );
      });

      test('note and note are null', () async {
        expect(
          Item(
            created,
            'name',
            null,
            null,
          ).toJson(),
          {
            'created': milliseconds,
            'name': 'name',
            'note': null,
            'url': null,
          },
        );
      });
    });
  });
}

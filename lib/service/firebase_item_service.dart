import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:utopia_recruitment_task/models/item_model.dart';
import 'package:utopia_recruitment_task/service/item_service.dart';

final collection = FirebaseFirestore.instance.collection('users');

class FirebaseItemService extends ItemService {
  @override
  Stream<List<Item>> createItemStream(String uid) => collection
      .doc(uid)
      .collection('items')
      .orderBy('created', descending: true)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(Item.fromSnapshot).toList(),
      );

  @override
  Future<void> saveItem(String uid, Item item) async {
    await collection
        .doc(uid)
        .collection('items')
        .add(item.toJson())
        .catchError((Object error) => throw Exception(error));
  }
}

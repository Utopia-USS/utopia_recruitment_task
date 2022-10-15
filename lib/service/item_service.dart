import 'package:utopia_recruitment_task/models/item_model.dart';

abstract class ItemService {
  Stream<List<Item>> createItemStream(String uid);

  Future saveItem(String uid, Item item);
}

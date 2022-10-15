import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final DateTime created;
  final String name;
  final String? note;
  final String? url;

  const Item(
    this.created,
    this.name,
    this.note,
    this.url,
  );

  factory Item.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Item(
      DateTime.fromMillisecondsSinceEpoch(snapshot.data()!['created']),
      snapshot.data()!['name'],
      snapshot.data()!['note'],
      snapshot.data()!['url'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'created': created.toUtc().millisecondsSinceEpoch,
      'name': name,
      'note': note,
      'url': url,
    };
  }

  @override
  List<Object?> get props => [created, name, note, url];
}

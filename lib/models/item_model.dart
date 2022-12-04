import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  const Item(
    this.created,
    this.name,
    this.note,
    this.url,
  );

  factory Item.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Item(
        DateTime.fromMillisecondsSinceEpoch(snapshot.data()!['created'] as int),
        snapshot.data()!['name'] as String,
        snapshot.data()!['note'] as String?,
        snapshot.data()!['url'] as String?,
      );

  final DateTime created;
  final String name;
  final String? note;
  final String? url;

  Map<String, Object?> toJson() => {
        'created': created.toUtc().millisecondsSinceEpoch,
        'name': name,
        'note': (note == null || note!.isEmpty) ? null : note,
        'url': (url == null || url!.isEmpty) ? null : url,
      };

  @override
  List<Object?> get props => [created, name, note, url];
}

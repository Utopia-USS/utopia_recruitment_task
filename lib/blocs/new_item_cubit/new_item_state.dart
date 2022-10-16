part of 'new_item_cubit.dart';

class NewItemState extends Equatable {
  final Name name;
  final String? note;
  final URL url;
  final FormzStatus status;

  const NewItemState({
    this.name = const Name.pure(),
    this.note,
    this.url = const URL.pure(),
    this.status = FormzStatus.pure,
  });

  NewItemState copyWith({
    Name? name,
    String? note,
    URL? url,
    FormzStatus? status,
  }) {
    return NewItemState(
      name: name ?? this.name,
      note: note ?? this.note,
      url: url ?? this.url,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [name, note, url, status];
}
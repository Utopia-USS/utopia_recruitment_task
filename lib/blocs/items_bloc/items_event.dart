part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItemsEvent extends ItemsEvent {
  final FirebaseUser user;

  const GetItemsEvent(this.user);

  @override
  List<Object> get props => [user];
}

class UpdatedItemsEvent extends ItemsEvent {
  final List<Item> items;

  const UpdatedItemsEvent(this.items);

  @override
  List<Object> get props => [items];
}

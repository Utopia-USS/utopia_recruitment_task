part of 'items_bloc.dart';

abstract class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItemsEvent extends ItemsEvent {
  const GetItemsEvent(this.user);

  final FirebaseUser user;

  @override
  List<Object> get props => [user];
}

class UpdatedItemsEvent extends ItemsEvent {
  const UpdatedItemsEvent(this.items);

  final List<Item> items;

  @override
  List<Object> get props => [items];
}

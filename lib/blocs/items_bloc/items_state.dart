part of 'items_bloc.dart';

abstract class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class InitialItemsState extends ItemsState {}

class LoadingItemsState extends ItemsState {}

class CompleteItemsState extends ItemsState {
  final List<Item> items;

  const CompleteItemsState(this.items);

  @override
  List<Object> get props => [items];
}

class ErrorItemsState extends ItemsState {}

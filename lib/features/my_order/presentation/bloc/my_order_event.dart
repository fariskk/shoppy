part of 'my_order_bloc.dart';

@immutable
sealed class MyOrderEvent {}

class AddREviewButtonClickedEvent extends MyOrderEvent {
  String productId;
  String comment;
  int rating;
  AddREviewButtonClickedEvent(
      {required this.comment, required this.productId, required this.rating});
}

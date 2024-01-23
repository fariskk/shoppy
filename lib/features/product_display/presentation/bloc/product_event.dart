part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ReloadEvent extends ProductEvent {}

class AddToCartButtonClickedEvent extends ProductEvent {
  Map productDetails;
  BuildContext context;
  AddToCartButtonClickedEvent(
      {required this.productDetails, required this.context});
}

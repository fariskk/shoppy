part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class QuantityIncreeseButtonClickedEvent extends HomeEvent {
  List myCart;
  int index;
  int currentCount;
  QuantityIncreeseButtonClickedEvent(
      {required this.index, required this.myCart, required this.currentCount});
}

class QuantitydecreeseButtonClickedEvent extends HomeEvent {
  List myCart;
  int index;
  int currentCount;
  QuantitydecreeseButtonClickedEvent(
      {required this.index, required this.myCart, required this.currentCount});
}

class DeleteCartItemButtonClickedEvent extends HomeEvent {
  List myCart;
  int index;
  DeleteCartItemButtonClickedEvent({required this.index, required this.myCart});
}

class ProceedToPaymentButtonClickedEvent extends HomeEvent {
  Map shippingAddres;
  List myCart;
  double amount;
  BuildContext context;
  ProceedToPaymentButtonClickedEvent(
      {required this.amount,
      required this.myCart,
      required this.shippingAddres,
      required this.context});
}

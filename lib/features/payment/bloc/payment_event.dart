part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class ProceedToPaymentButtonClickedEvent extends PaymentEvent {
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

class PlaceOrderButtonClickedEvent extends PaymentEvent {
  double amount;
  BuildContext context;
  Map orderDetails;
  PlaceOrderButtonClickedEvent(
      {required this.amount,
      required this.context,
      required this.orderDetails});
}

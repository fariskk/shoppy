part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

// class ProceedToPaymentButtonClickedEvent extends PaymentEvent {
//   Map shippingAddres;
//   List myCart;
//   double amount;
//   BuildContext context;
//   ProceedToPaymentButtonClickedEvent(
//       {required this.amount,
//       required this.myCart,
//       required this.shippingAddres,
//       required this.context});
// }
class NextButtonClickedEvent extends PaymentEvent {
  BuildContext context;
  Map address;
  NextButtonClickedEvent({required this.context, required this.address});
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

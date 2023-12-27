import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static String? _tokenData;

  static String publishableKey =
      // "pk_test_51OHhjDB5Cpi5domYGusHgDy30m8MPb7e48Qe0giXypvrFElyd5FUV7T0DvZMpyLuRYZprloaaBDtwJOvOiO3wLOa00fncnEhIm";
      // "pk_test_51KP3c7DBTVUYOnmbqwLQZNSYuY6i3Lg57A71uPRtDvwPPSnIQqPlN4fvK4xLIWJ60ev4NkNomniMOf5ORSQtaAVx009gK7gzm5";
      "pk_test_51JO2TnCAYsMkXrZLvUbfzYNvaUe09sGB9W4iGi44D5VvWNY8ZGaCLQaWQoDbZTxVmxnYc1NqTVzmImuFzgvHBy9O00xgR1F1zL";

  static void init() {
    Stripe.publishableKey = publishableKey;
  }

  /*static Future<String?> getCardToken() async {
    CardDetails _card = CardDetails();

    _card = _card.copyWith(number: "4242424242424242");
    _card = _card.copyWith(
        expirationMonth: int.tryParse("12"));
    _card = _card.copyWith(
        expirationYear: int.tryParse("2024"));
    _card = _card.copyWith(cvc: "123");
    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(_card);

      PaymentMethod paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
              billingDetails: BillingDetails(name: "David Willy")),
        ),
      );
      // Handle the obtained paymentMethod, which contains the card token
      String cardToken = paymentMethod.id;

      if (kDebugMode) {
        print("stripe json: ${paymentMethod.toJson()}");
        print('Card token: $cardToken');
      }
      return cardToken;
    } catch (error) {
      if (kDebugMode) {
        print('Error obtaining card token: $error');
      }
      return null;
    }
  }*/

  static Future<String?> getCardToken() async {
    CardDetails _card = CardDetails();

    _card = _card.copyWith(number: "4242424242424242");
    _card = _card.copyWith(expirationMonth: int.tryParse("12"));
    _card = _card.copyWith(expirationYear: int.tryParse("2024"));
    _card = _card.copyWith(cvc: "123");
    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(_card);

      // PaymentMethod paymentMethod = await Stripe.instance.createPaymentMethod(
      //   params: const PaymentMethodParams.card(
      //     paymentMethodData: PaymentMethodData(
      //         billingDetails: BillingDetails(name: "David Willy")),
      //   ),
      // );
      TokenData tokenData = await Stripe.instance.createToken(
          const CreateTokenParams.card(
              params: CardTokenParams(
                  type: TokenType.Card,
                  name: "xyz",
                  address: Address(
                      city: '',
                      country: '',
                      line1: '',
                      line2: '',
                      postalCode: '',
                      state: ''),
                  currency: 'usd')));

      // Handle the obtained paymentMethod, which contains the card token
      // print("stripe json: ${paymentMethod.toJson()}");
      // String cardToken = tokenData.id;
      String cardToken = tokenData.id;
      if (kDebugMode) {
        print('Card token: ${tokenData.toJson()}');
      }
      return cardToken;
    } catch (error) {
      if (kDebugMode) {
        print('Error obtaining card token: $error');
      }
      return null;
    }
  }
}

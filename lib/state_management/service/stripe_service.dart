import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:side_hustle/state_management/service/socket_service.dart';

class StripeService {
  static String publishableKey = "pk_test_ivDPnZFWiO2DLqplolk3L4Zf00bYZssYXd";

  /// Live

  static void init() {
    Stripe.publishableKey = publishableKey;
  }

  static Future<StripTokenModel?> getCardToken(
      {required CardDetails cardDetails}) async {
    // SocketManager.init();
    try {
      await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

      PaymentMethod tokenData = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
              billingDetails: BillingDetails(name: "David Willy")),
        ),
      );
      // TokenData tokenData = await Stripe.instance.createToken(
      //     const CreateTokenParams.card(
      //         params: CardTokenParams(
      //             type: TokenType.Card,
      //             name: "xyz",
      //             address: Address(
      //                 city: '',
      //                 country: '',
      //                 line1: '',
      //                 line2: '',
      //                 postalCode: '',
      //                 state: ''),
      //             currency: 'usd')));

      String cardToken = tokenData.id;
      if (kDebugMode) {
        print('Card token: ${tokenData.toJson()}');
      }
      return StripTokenModel(status: 1, token: cardToken);
      // return cardToken;
    } catch (error) {
      StripeException stripeException = error as StripeException;
      if (kDebugMode) {
        print(
            'Error obtaining card token: $error\n\n\nstripeException: ${stripeException.error.message}');
      }
      return StripTokenModel(status: 0, message: stripeException.error.message);
    }
  }
}

class StripTokenModel {
  final String? token;
  final String? message;
  final int status;

  StripTokenModel({this.token, this.message, this.status = 0});
}

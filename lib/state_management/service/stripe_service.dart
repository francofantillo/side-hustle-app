import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  CardFieldInputDetails? _card;

  static TokenData? _tokenData;

  static String publishableKey =
      "pk_test_51OHhjDB5Cpi5domYGusHgDy30m8MPb7e48Qe0giXypvrFElyd5FUV7T0DvZMpyLuRYZprloaaBDtwJOvOiO3wLOa00fncnEhIm";

  static void init() {
    Stripe.publishableKey = publishableKey;
  }

  static Future<String?> createCardToken({
    required String cardNumber,
    required String expMonth,
    required int expYear,
    required String cvc,
  }) async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.fromJson({
        "number": cardNumber, // Replace with your card number
        "expMonth": expMonth, // Replace with expiration month
        "expYear": expYear, // Replace with expiration year
        "cvc": cvc, // Replace with CVC
      })); // How to generate card token using flutter_stripe

      final TokenData tokenData = await Stripe.instance.createToken(
        const CreateTokenParams.card(
          params: CardTokenParams(type: TokenType.Card),
        ),
      );

      return paymentMethod?.id;
    } catch (e) {
      print('Error creating card token: $e');
      return null;
    }
  }

/*  Future<void> createCardToken() async {
    try {
      final token = await Stripe.instance.createToken(
        CardParams(
          number: '4242424242424242', // Replace with your card number
          expMonth: 12, // Replace with expiration month
          expYear: 2023, // Replace with expiration year
          cvc: '123', // Replace with CVC
        ),
      );

      // Handle the created token (token)
      // Further logic or handling of the token object
    } catch (e) {
      // Handle errors that might occur during token creation
      print('Error creating card token: $e');
    }
  }*/

  static Future<void> createCardPaymentMethod() async {
    try {
      final data = {
        "number": "4242424242424242",
        "expMonth": "12",
        "expYear": "2024",
        "cvc": "123",
        "currency": "USD",
      };

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData.fromJson(data),
        ),
      );

      print(paymentMethod.id);

      // Handle the created payment method (paymentMethod)
      // Further logic or handling of the paymentMethod object
    } catch (e) {
      // Handle errors that might occur during payment method creation
      print('Error creating card payment method: $e');
    }
  }

  static Future<void> handleCreateTokenPress() async {
    // if (_card == null) {
    //   return;
    // }

    final data = {
      "number": "4242424242424242",
      "expMonth": "12",
      "expYear": "2024",
      "cvc": "123",
      "type": "Card",
      "currency": "USD",
    };
    try {
      // 1. Gather customer billing information (ex. email)
      final address = Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ); // mocked data for tests

      // 2. Create payment method
      final tokenData = await Stripe.instance.createToken(CreateTokenParams.card(
          // params: CardTokenParams(address: address, currency: 'USD' ,type: TokenType.Card)));
          params: CardTokenParams.fromJson(data)));
      // setState(() {
      //   this.tokenData = tokenData;
      // });
      _tokenData = tokenData;
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: Text('Success: The token was created successfully!')));
      print("'Success: The token was created successfully!'");
      return;
    } catch (e) {
      print('Error: $e');
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Error: $e')));
      rethrow;
    }
  }

  static Future<void> handleCreateTokenPressNew() async {
    final data = {
      "number": "4242424242424242",
      "expMonth": "12",
      "expYear": "2024",
      "cvc": "123",
      "currency": "USD",
    };
    try {
      final tokenData = await Stripe.instance.createToken(
          CreateTokenParams.card(params: CardTokenParams.fromJson(data)));

      _tokenData = tokenData;

      print("'Success: The token was created successfully!'");
      return;
    } catch (e) {
      print('Error: $e');

      rethrow;
    }
  }

  /*static Future<void> handleCreateTokenPressNew() async {
    try {
      final data = {
        "number": "4242424242424242",
        "expMonth": "12",
        "expYear": "2024",
        "cvc": "123",
        "currency": "USD",
      };

      final cardTokenParams = CardTokenParams(
        number: '4242424242424242',
        expMonth: 12,
        expYear: 2024,
        cvc: '123',
        currency: 'USD',
      );

      final tokenData = await Stripe.instance.createToken(
        CreateTokenParams.card(params: Creatca),
      );

      _tokenData = tokenData;

      print('Success: The token was created successfully!');
      return;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }*/

}

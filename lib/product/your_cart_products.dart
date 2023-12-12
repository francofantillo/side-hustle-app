import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/products/products_cart_list.dart';
import 'package:side_hustle/service/widgets/delivery_address_your_cart.dart';
import 'package:side_hustle/service/widgets/your_cart_appbar.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class YourProductsCart extends StatefulWidget {
  final bool isDelivery;

  const YourProductsCart({super.key, this.isDelivery = true});

  @override
  State<YourProductsCart> createState() => _YourProductsCartState();
}

class _YourProductsCartState extends State<YourProductsCart> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      // floatingActionButton: const DeliveryAddressYourCart(isDelivery: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(0.02.sw),
          const YourCartAppBar(itemsCount: 4),
          height(0.02.sw),
          const ProductsCartList(),
          const DeliveryAddressYourCart(isDelivery: true),
        ],
      ),
    );
  }
}

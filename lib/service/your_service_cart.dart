import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/services/services_cart_list.dart';
import 'package:side_hustle/service/widgets/delivery_address_your_cart.dart';
import 'package:side_hustle/service/widgets/your_cart_appbar.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class YourServiceCart extends StatefulWidget {
  final bool isDelivery;

  const YourServiceCart({super.key, this.isDelivery = true});

  @override
  State<YourServiceCart> createState() => _YourServiceCartState();
}

class _YourServiceCartState extends State<YourServiceCart> {
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      // floatingActionButton: const DeliveryAddressYourCart(isDelivery: true, isOrderService: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(0.02.sw),
          const YourCartAppBar(itemsCount: 4),
          height(0.02.sw),
          const ServicesCartList(),
          const DeliveryAddressYourCart(
            isDelivery: true,
            isOrderService: true,
          ),
          // height(0.7.sw),
        ],
      ),
    );
  }
}

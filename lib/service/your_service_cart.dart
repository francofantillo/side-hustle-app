import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_delivery_address.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/modal_bottom_sheet_products.dart';
import 'package:side_hustle/cart/services/services_cart_list.dart';
import 'package:side_hustle/chat/chat_one_to_one.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/widgets/delivery_address_your_cart.dart';
import 'package:side_hustle/service/widgets/your_cart_appbar.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
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
      floatingActionButton: const DeliveryAddressYourCart(isDelivery: true, isOrderService: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(0.02.sw),
          const YourCartAppBar(itemsCount: 4),
          height(0.02.sw),
          const ServicesCartList(),
          height(0.7.sw),
        ],
      ),
    );
  }
}

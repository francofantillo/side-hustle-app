import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/products/products_cart_list.dart';
import 'package:side_hustle/service/widgets/delivery_address_your_cart.dart';
import 'package:side_hustle/service/widgets/your_cart_appbar.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class YourProductsCart extends StatefulWidget {
  final bool isDelivery;

  const YourProductsCart({super.key, this.isDelivery = true});

  @override
  State<YourProductsCart> createState() => _YourProductsCartState();
}

class _YourProductsCartState extends State<YourProductsCart> {
  late final SideHustleCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getCart();
    super.initState();
  }

  getCart() async {
    EasyLoading.show();
    await _bloc
        .getSideHustleCartCubit(context: context, mounted: mounted)
        .then((value) => EasyLoading.dismiss());
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      // floatingActionButton: const DeliveryAddressYourCart(isDelivery: true),
      body: BlocBuilder<SideHustleCubit, SideHustleState>(
          builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(0.02.sw),
            YourCartAppBar(itemsCount: state.cartModel?.data?.totalItems ?? 0),
            height(0.02.sw),
            const ProductsCartList(),
            state.cartLoading
                ? const SizedBox.shrink()
                : state.cartModel?.data?.cartDetails?.isEmpty ?? true
                    ? const SizedBox.shrink()
                    : DeliveryAddressYourCart(
                        isDelivery: state.cartModel?.data?.isAddress != null
                            ? state.cartModel!.data!.isAddress == 1
                                ? true
                                : false
                            : false),
          ],
        );
      }),
    );
  }
}

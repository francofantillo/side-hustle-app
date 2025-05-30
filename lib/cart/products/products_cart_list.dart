import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/cart/products/product_cart_item.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class ProductsCartList extends StatefulWidget {
  const ProductsCartList({super.key});

  @override
  State<ProductsCartList> createState() => _ProductsCartListState();
}

class _ProductsCartListState extends State<ProductsCartList> {
  late final SideHustleCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideHustleCubit, SideHustleState>(
        builder: (context, state) {
      return state.cartLoading
          ? const SizedBox.shrink()
          : state.cartModel?.data?.cartDetails?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageNoItemsFound),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
                    itemCount: state.cartModel?.data?.cartDetails?.length ?? 0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8),
                        child: ProductCartItemWidget(
                          onTapDecrement: () async {
                            if (state
                                    .cartModel?.data?.cartDetails?[index].qty !=
                                null) {
                              int qty = state
                                  .cartModel!.data!.cartDetails![index].qty!;
                              if (qty > 1) {
                                final decrementQty = qty - 1;

                                await _bloc.updateQuantityCartCubit(
                                    context: context,
                                    mounted: mounted,
                                    cartDetailId: state.cartModel?.data
                                        ?.cartDetails?[index].id,
                                    qty: decrementQty);
                              }
                            }
                          },
                          onTapIncrement: () async {
                            if (state
                                    .cartModel?.data?.cartDetails?[index].qty !=
                                null) {
                              int qty = state
                                  .cartModel!.data!.cartDetails![index].qty!;
                              final incrementQty = qty + 1;
                              print("incrementQty: $incrementQty");
                              await _bloc.updateQuantityCartCubit(
                                  context: context,
                                  mounted: mounted,
                                  cartDetailId: state
                                      .cartModel?.data?.cartDetails?[index].id,
                                  qty: incrementQty);
                            }
                          },
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.cartItemProductHeight,
                          boarderColor: AppColors.itemBGColor,
                          qty: state.cartModel?.data?.cartDetails?[index].qty,
                          title: state
                              .cartModel?.data?.cartDetails?[index].productName,
                          subTitle: state
                              .cartModel?.data?.cartDetails?[index].description,
                          imagePath: state.cartModel?.data?.cartDetails?[index]
                              .productImage,
                          price: state
                                  .cartModel?.data?.cartDetails?[index].price
                                  ?.toStringAsFixed(2) ??
                              "0",
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                );
    });
  }
}

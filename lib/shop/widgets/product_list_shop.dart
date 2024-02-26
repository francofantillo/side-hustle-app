import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/product/widgets/products_items.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class ProductsListShop extends StatefulWidget {
  const ProductsListShop({super.key});

  @override
  State<ProductsListShop> createState() => _ProductsListShopState();
}

class _ProductsListShopState extends State<ProductsListShop> {
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
      return state.otherUserShopLoading
          ? const SizedBox.shrink()
          : state.otherUserShopModel?.shopData?.products?.isEmpty ?? true
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
                    itemCount:
                        state.otherUserShopModel?.shopData?.products?.length ??
                            0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        // padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                        padding: EdgeInsets.only(
                            right: 16.0.w, left: 16.0.w, top: 8),
                        child: ProductsItemsWidget(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.viewProductScreenRoute,
                                arguments: ViewProduct(
                                  isViewingProductFromOthersShop: true,
                                  id: state.otherUserShopModel?.shopData
                                      ?.products?[index].id,
                                ));
                          },
                          onTapAdd: () async {
                            _bloc
                                .checkIsOtherShop(
                                    shopId: state.otherUserShopModel?.shopData
                                        ?.shopDetail?.id)
                                .then((value) async {
                              if (value == 1) {
                                /// Show Cart Clear Dialog
                                await _bloc.addToCartCubit(
                                    context: context,
                                    mounted: mounted,
                                    shopId: state.otherUserShopModel?.shopData
                                        ?.shopDetail?.id,
                                    productId: state.otherUserShopModel
                                        ?.shopData?.products?[index].id);
                              } else {
                                /// Add Product
                                await _bloc.addToCartCubit(
                                    context: context,
                                    mounted: mounted,
                                    shopId: state.otherUserShopModel?.shopData
                                        ?.shopDetail?.id,
                                    productId: state.otherUserShopModel
                                        ?.shopData?.products?[index].id);
                              }
                            });
                          },
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.sideHustleItemHeight,
                          boarderColor: AppColors.itemBGColor,
                          title: state.otherUserShopModel?.shopData
                              ?.products?[index].name,
                          subTitle: state.otherUserShopModel?.shopData
                              ?.products?[index].description,
                          deliveryType: AppStrings.pickUpViewProduct,
                          imagePath: state.otherUserShopModel?.shopData
                              ?.products?[index].image,
                          price: state.otherUserShopModel?.shopData
                              ?.products?[index].price
                              ?.toStringAsFixed(2),
                        ),
                      );
                    },
                  ),
                );
    });
  }
}

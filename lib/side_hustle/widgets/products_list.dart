import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/product/widgets/products_items.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/state_management/models/side_hustle_model.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dialogues.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
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
      return state.sideHustleLoading
          ? const SizedBox.shrink()
          : state.sideHustleModel?.sideHustleData?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageProducts),
                )
              : sideHustleProduct(
                  sideHustleItemList: state.searching
                      ? state.sideHustleTempList
                      : state.sideHustleModel?.sideHustleData);
    });
  }

  Widget sideHustleProduct({List<SideHustleData>? sideHustleItemList}) {
    return sideHustleItemList?.isEmpty ?? true
        ? const Expanded(
            child: CustomErrorWidget(
                errorMessage: AppStrings.errorMessageProducts),
          )
        : Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
              itemCount: sideHustleItemList?.length ?? 0,
              // Replace with your item count
              itemBuilder: (context, index) {
                // Replace with your horizontal list item
                return Padding(
                  // padding: EdgeInsets.only(right: 16.0, left: 8.0, top: 0.015.sh),
                  padding:
                      const EdgeInsets.only(right: 16.0, left: 8.0, top: 8),
                  child: ProductsItemsWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.viewProductScreenRoute,
                          arguments: ViewProduct(
                            id: sideHustleItemList?[index].id,
                          ));
                    },
                    onTapAdd: () async {
                      _bloc
                          .checkIsOtherShop(
                              shopId: sideHustleItemList?[index].shopId)
                          .then((value) async {
                        if (value == 1) {
                          /// Show Cart Clear Dialog
                          AppDialogues.showCartClearInfo(
                              context: context,
                              onPressedOk: () async {
                                /// Clear Cart
                                await _bloc.addToCartCubit(
                                    context: context,
                                    mounted: mounted,
                                    shopId: sideHustleItemList?[index].shopId,
                                    productId: sideHustleItemList?[index].id);
                              }).show();
                        } else {
                          /// Add Product
                          await _bloc.addToCartCubit(
                              context: context,
                              mounted: mounted,
                              shopId: sideHustleItemList?[index].shopId,
                              productId: sideHustleItemList?[index].id);
                        }
                      });
                    },
                    imageWidth: 1.sw,
                    imageHeight: AppDimensions.sideHustleItemHeight,
                    boarderColor: AppColors.itemBGColor,
                    title: sideHustleItemList?[index].name,
                    subTitle: sideHustleItemList?[index].description,
                    imagePath: sideHustleItemList?[index].image,
                    price: sideHustleItemList?[index].price?.toStringAsFixed(2),
                  ),
                );
              },
            ),
          );
  }
}

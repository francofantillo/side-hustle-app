import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/product/post_product.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/product/widgets/your_products_item.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class YourProductsListShop extends StatefulWidget {
  final bool isEdit;

  const YourProductsListShop({super.key, this.isEdit = false});

  @override
  State<YourProductsListShop> createState() => _YourProductsListShopState();
}

class _YourProductsListShopState extends State<YourProductsListShop> {
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
      return state.yourShopLoading
          ? const SizedBox.shrink()
          : state.yourShopModel?.shopData?.products?.isEmpty ?? true
              ? const Expanded(
                  child: CustomErrorWidget(
                      errorMessage: AppStrings.errorMessageJobs),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
                    itemCount:
                        state.yourShopModel?.shopData?.products?.length ?? 0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        // padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                        padding: EdgeInsets.only(
                            right: 16.0.w, left: 16.0.w, top: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.viewProductScreenRoute,
                                arguments: ViewProduct(
                                  isMyProduct: true,
                                  id: state.yourShopModel?.shopData
                                      ?.products?[index].id,
                                  isEditFromShop: true,
                                ));
                          },
                          child: YourProductsItemWidget(
                            imageWidth: 1.sw,
                            isDelete: widget.isEdit,
                            imageHeight: AppDimensions.sideHustleItemHeight,
                            boarderColor: AppColors.itemBGColor,
                            title: state
                                .yourShopModel?.shopData?.products?[index].name,
                            desc: state.yourShopModel?.shopData
                                ?.products?[index].description,
                            deliveryType: state.yourShopModel?.shopData
                                        ?.products?[index].deliveryType !=
                                    null
                                ? state.yourShopModel!.shopData!
                                            .products![index].deliveryType ==
                                        DeliveryTypeEnum.Pickup.name
                                    ? AppStrings.deliveryOptionPickup
                                    : AppStrings.deliveryOptionCOD
                                : "",
                            imagePath: state.yourShopModel?.shopData
                                ?.products?[index].image,
                            price: state
                                .yourShopModel?.shopData?.products?[index].price
                                ?.toStringAsFixed(2),
                            onTap: () async {
                              if (widget.isEdit) {
                                await _bloc.deleteSideHustleCubit(
                                    context: context,
                                    mounted: mounted,
                                    id: state.yourShopModel?.shopData
                                        ?.products?[index].id);
                              } else {
                                Navigator.pushNamed(
                                    context, AppRoutes.postProductScreenRoute,
                                    arguments: PostProduct(
                                      isEdit: true,
                                      id: state.yourShopModel?.shopData
                                          ?.products?[index].id,
                                      isEditFromShop: true,
                                    ));
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
    });
  }
}

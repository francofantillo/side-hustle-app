import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/view_service.dart';
import 'package:side_hustle/service/widgets/service_item.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class ServicesListShop extends StatefulWidget {
  const ServicesListShop({super.key});

  @override
  State<ServicesListShop> createState() => _ServicesListShopState();
}

class _ServicesListShopState extends State<ServicesListShop> {
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
          : state.otherUserShopModel?.shopData?.services?.isEmpty ?? true
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
                        state.otherUserShopModel?.shopData?.services?.length ??
                            0,
                    // Replace with your item count
                    itemBuilder: (context, index) {
                      // Replace with your horizontal list item
                      return Padding(
                        // padding: const EdgeInsets.only(right: 16.0, left: 8.0),
                        padding: const EdgeInsets.only(
                            right: 16.0, left: 8.0, top: 8),
                        child: ServiceItemsWidget(
                          imageWidth: 1.sw,
                          imageHeight: AppDimensions.sideHustleItemHeight,
                          boarderColor: AppColors.itemBGColor,
                          title: state.otherUserShopModel?.shopData
                              ?.services?[index].name,
                          subTitle: state.otherUserShopModel?.shopData
                              ?.services?[index].description,
                          serviceType: AppStrings.pickUpViewProduct,
                          imagePath: state.otherUserShopModel?.shopData
                              ?.services?[index].image,
                          price:
                          state.otherUserShopModel?.shopData
                              ?.services?[index].price?.toStringAsFixed(2),
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
                                        ?.shopData?.services?[index].id);
                              } else {
                                /// Add Product
                                await _bloc.addToCartCubit(
                                    context: context,
                                    mounted: mounted,
                                    shopId: state.otherUserShopModel?.shopData
                                        ?.shopDetail?.id,
                                    productId: state.otherUserShopModel
                                        ?.shopData?.services?[index].id);
                              }
                            });
                          },
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.viewServiceScreenRoute,
                                arguments: ViewService(
                                  isViewingServiceFromOthersShop: true,
                                  id: state.otherUserShopModel?.shopData
                                      ?.services?[index].id,
                                ));
                          },
                        ),
                      );
                    },
                  ),
                );
    });
  }
}

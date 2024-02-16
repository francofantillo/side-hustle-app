import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/post_service.dart';
import 'package:side_hustle/service/view_service.dart';
import 'package:side_hustle/service/widgets/your_service_item.dart';
import 'package:side_hustle/state_management/cubit/side_hustle/side_hustle_cubit.dart';
import 'package:side_hustle/utils/alpha_app_data.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_enums.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/error/error_widget.dart';

class YourServicesListShop extends StatefulWidget {
  final bool isEdit;

  const YourServicesListShop({super.key, this.isEdit = false});

  @override
  State<YourServicesListShop> createState() => _YourServicesListShopState();
}

class _YourServicesListShopState extends State<YourServicesListShop> {
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
          : state.yourShopModel?.shopData?.services?.isEmpty ?? true
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
                        state.yourShopModel?.shopData?.services?.length ?? 0,
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
                                context, AppRoutes.viewServiceScreenRoute,
                                arguments: ViewService(
                                  isMyService: true,
                                  id: state.yourShopModel?.shopData
                                      ?.services?[index].id,
                                ));
                          },
                          // I need 2 horizontal Listview builders inside a vertical scrollview flutter
                          child: YourServiceItemWidget(
                            imageWidth: 1.sw,
                            isDelete: widget.isEdit,
                            imageHeight: AppDimensions.sideHustleItemHeight,
                            boarderColor: AppColors.itemBGColor,
                            title: state
                                .yourShopModel?.shopData?.services?[index].name,
                            desc: state.yourShopModel?.shopData
                                ?.services?[index].description,
                            serviceType: state.yourShopModel?.shopData
                                        ?.services?[index].serviceType !=
                                    null
                                ? state.yourShopModel!.shopData!
                                            .services![index].serviceType ==
                                        ServiceTypeEnum.Hourly.name
                                    ? ServiceTypeEnum.Hourly.name
                                    : ServiceTypeEnum.Fixed.name
                                : "",
                            imagePath: state.yourShopModel?.shopData
                                ?.services?[index].image,
                            price: state
                                .yourShopModel?.shopData?.services?[index].price
                                ?.toStringAsFixed(2),
                            onTap: () async {
                              if (widget.isEdit) {
                                await _bloc.deleteSideHustleCubit(
                                    context: context,
                                    mounted: mounted,
                                    id: state.yourShopModel?.shopData
                                        ?.services?[index].id);
                              } else {
                                Navigator.pushNamed(
                                    context, AppRoutes.postServiceScreenRoute,
                                    arguments: const PostService(
                                      isEdit: true,
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

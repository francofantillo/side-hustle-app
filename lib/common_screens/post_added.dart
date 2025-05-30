import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/event/view_event_self.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/service/view_service.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/custom_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PostAdded extends StatelessWidget {
  final String? title, subTitle, buttonName;
  final int? id;
  final bool isProduct, isEvent, isService;

  const PostAdded(
      {super.key,
      this.id,
      this.title,
      this.subTitle,
      this.buttonName = "",
      this.isProduct = false,
      this.isService = false,
      this.isEvent = false});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("PostAdded: $id");
    }
    return BackgroundWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // height(0.2.sh),
          // Padding(
          //   padding: const EdgeInsets.all(32.0),
          //   child: CustomCacheImage(
          //     showLoading: false,
          //     imageHeight: 0.28.sh,
          //     imageWidth: 1.sw,
          //     assetImage: AssetsPath.logo,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 48.w),
            child: CustomCacheImage(
              showLoading: false,
              // imageHeight: 300.w,
              imageHeight: 0.6.sw,
              imageWidth: 1.sw,
              assetImage: AssetsPath.sideHustlePosted,
            ),
          ),
          height(0.01.sh),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: textWidget(
                text: title,
                color: AppColors.textBlackColor,
                fontFamily: AppFont.gilroyBold,
                fontSize: AppDimensions.textSizeBottomSheet,
                fontWeight: FontWeight.bold),
          ),
          height(0.02.sw),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: textWidget(
                text: subTitle,
                color: AppColors.textBlackColor,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontSize: AppDimensions.textSizeSmall),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: CustomMaterialButton(
                onPressed: () {
                  if (isProduct) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.viewProductScreenRoute,
                        arguments: ViewProduct(
                          isMyProduct: true,
                          id: id,
                        ));
                  } else if (isService) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.viewServiceScreenRoute,
                        arguments: ViewService(
                          isMyService: true,
                          id: id,
                        ));
                  } else if (isEvent) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.viewEventSelfScreenRoute,
                        arguments: ViewEventSelf(
                          id: id,
                          isEventEditFromPostAdded: true,
                        ));
                  }
                },
                name: buttonName,
                borderRadius: AppDimensions.boarderRadiusCartPlaceOrder,
                color: AppColors.primaryColor,
                textColor: AppColors.whiteColor),
          ),
          height(0.05.sh),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/product/view_product.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PostAdded extends StatelessWidget {
  final String? title, subTitle, buttonName;
  final bool isProduct, isEvent;

  const PostAdded(
      {super.key,
      this.title,
      this.subTitle,
      this.buttonName = "",
      this.isProduct = false,
      this.isEvent = false});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          height(0.2.sh),
          CircularCacheImageWidget(showLoading: false,
          imageHeight: 0.3.sh,
          imageWidth: 0.3.sh,

          ),
          height(0.01.sh),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: textWidget(
                text: title,
                color: AppColors.textBlackColor,
                fontSize: AppDimensions.textSizeBottomSheet,
                fontWeight: FontWeight.w500),
          ),
          height(0.01.sh),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            child: customMaterialButton(
                onPressed: () {
                  if (isProduct) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.viewProductScreenRoute,
                        arguments: const ViewProduct(
                          isMyProduct: true,
                        ));
                  } else if (isEvent) {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.viewEventSelfScreenRoute);
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

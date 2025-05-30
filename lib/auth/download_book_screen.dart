import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class DownloadBookScreen extends StatefulWidget {
  const DownloadBookScreen({super.key});

  @override
  State<DownloadBookScreen> createState() => _DownloadBookScreenState();
}

class _DownloadBookScreenState extends State<DownloadBookScreen> {
  late final AuthCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getHustler();
    super.initState();
  }

  getHustler() async {
    await _bloc.getHustlerCubit(context: context, mounted: mounted);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          return state.getResumeLoading
              ? const SizedBox.shrink()
              : CustomMaterialButton(
                  borderRadius: 14,
                  fontSize: AppDimensions.textSizeSmall,
                  onPressed: () async {
                    print("Pdf: ${state.resumeModel?.data?.file}");
                    if (state.resumeModel?.data?.file != null) {
                      await AppUtils.launchURL(
                          url: state.resumeModel!.data!.file!);
                    } else {
                      AppUtils.showToast(AppStrings.errorMessage);
                    }
                  },
                  name: AppStrings.downloadThisBook,
                  textColor: AppColors.whiteColor,
                  color: AppColors.primaryColor);
        }),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return state.getResumeLoading
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    height(0.05.sw),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: textWidget(
                          text: AppStrings.howToHustler,
                          color: AppColors.blackColor,
                          fontSize: AppDimensions.textHeadingSizeHome,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 2.0, left: 24, right: 24),
                      child: textWidget(
                          text: AppStrings.howToHustlerSubText,
                          textAlign: TextAlign.center,
                          color: AppColors.blackColor,
                          maxLines: 2,
                          fontSize: AppDimensions.textSizeSmall),
                    ),
                    height(0.05.sw),
                    Center(
                        child: Container(
                      height: AppDimensions.downloadBookSize,
                      // width: .7.sw,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: AssetImage(
                              AssetsPath.downloadBook,
                            ),
                          )),
                    )),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 32, right: 32),
                      child: textWidget(
                          text: AppStrings.howToHustlerPdf,
                          textAlign: TextAlign.center,
                          color: AppColors.primaryColor,
                          maxLines: 2,
                          fontSize: AppDimensions.textSize10),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/pdf_view/pdf_view_screen.dart';
import 'package:side_hustle/profile/your_resume_edit.dart';
import 'package:side_hustle/router/app_route_named.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class YourResume extends StatefulWidget {
  const YourResume({super.key});

  @override
  State<YourResume> createState() => _YourResumeState();
}

class _YourResumeState extends State<YourResume> {
  late final AuthCubit _bloc;

  final List<String> itemsList = [
    "Hobbies 1",
    "Hobbies 2",
    "Hobbies 3",
  ];

  // _launchURL({required String pdfPath}) async {
  //   // final pdfUrl = Uri.parse('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');
  //   final pdfUrl = Uri.parse(pdfPath);
  //
  //   if (await canLaunchUrl(pdfUrl)) {
  //     await launchUrl(pdfUrl);
  //   } else {
  //     throw 'Could not launch $pdfUrl';
  //   }
  // }

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getResume();
    super.initState();
  }

  getResume() async {
    await _bloc.getResumeCubit(context: context, mounted: mounted);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.yourResume,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: [
        BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
          return state.getResumeLoading
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(right: 12.0, top: 8),
                  child: CircularIconButton(
                    onPressed: () {
                      final List itemsList = [];
                      if (state.resumeModel?.data?.hobbies != null) {
                        for (int i = 0;
                            i < (state.resumeModel?.data?.hobbies?.length ?? 0);
                            i++) {
                          itemsList
                              .add(state.resumeModel?.data?.hobbies?[i].hobby);
                        }
                      }
                      Navigator.pushNamed(
                          context, AppRoutes.yourResumeEditScreenRoute,
                          arguments: YourResumeEdit(
                            itemsList: itemsList,
                            profileImagePath:
                                state.resumeModel?.data?.profileImage,
                            pdfFileName: state.resumeModel?.data?.filename,
                            pdfFilePath: state.resumeModel?.data?.file,
                          ));
                    },
                    width: 0.10.sw,
                    height: 0.10.sw,
                    icon: Icons.edit,
                    backgroundColor: AppColors.backIconBackgroundColor,
                    iconSize: 14,
                    iconColor: AppColors.primaryColor,
                  ),
                );
        })
      ],
      body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        print("Profile Image: ${state.resumeModel?.data?.profileImage}");
        print("actual Name Length: ${state.resumeModel?.data?.actualName?.length}");
        return state.getResumeLoading
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.rootPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircularCacheImageWidget(
                            showLoading: true,
                            // image:
                            //     AlphaAppData.dpProfile,
                            image: state.resumeModel?.data?.profileImage,
                            // image: "http://fastly.picsum.photos/id/39/200/300.jpg?hmac=CcUiRU6-82MldMqtiF9shpKCbwzwkILEWuRi90JsADs",
                            assetImage: AssetsPath.placeHolder,
                            boarderColor: AppColors.primaryColor,
                            imageHeight: 0.28.sw,
                            imageWidth: 0.28.sw,
                            borderWidth: .005.sw,
                          ),
                          // width(0.02.sw),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget(
                                      // text: AppStrings.davidHan,
                                      text: state.resumeModel?.data?.actualName,
                                      maxLines: 1,
                                      color: AppColors.textBlackColor,
                                      fontFamily: AppFont.gilroyBold,
                                      fontSize: AppDimensions.textHeadingSize,
                                      fontWeight: FontWeight.bold),
                                  // height(0.001.sw),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 1),
                                    child: textWidget(
                                        // text: AppStrings.nickname,
                                        text: state.resumeModel?.data?.nickName,
                                        maxLines: 1,
                                        fontSize: AppDimensions.textSizeSmall),
                                  ),
                                  // height(0.01.sw),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 1),
                                    child: textWidget(
                                        // text: AppStrings.profession,
                                        text: state.resumeModel?.data?.profession,
                                        maxLines: 1,
                                        fontSize: AppDimensions.textSizeSmall),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      height(0.08.sw),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.familyTies,
                            maxLines: 1,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSizeSmall,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.02.sw),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, right: 8, bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.borderColorResumePage)),
                            child: textWidget(
                              // text: AppStrings.familyTies,
                              text: state.resumeModel?.data?.familyTies,
                              fontSize: AppDimensions.textSizeVerySmall,
                              fontFamily: AppFont.gilroyMedium,
                              maxLines: 1,
                            ),
                          )),
                      height(AppDimensions.formFieldsBetweenSpacing),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.professionalBackground,
                            maxLines: 1,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSizeSmall,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.02.sw),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, right: 8, bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.borderColorResumePage)),
                            child: textWidget(
                              // text: AppStrings.professionalBackgroundHint,
                              text: state
                                  .resumeModel?.data?.professionalBackground,
                              fontSize: AppDimensions.textSizeVerySmall,
                              fontFamily: AppFont.gilroyMedium,
                              maxLines: 1,
                            ),
                          )),
                      height(AppDimensions.formFieldsBetweenSpacing),
                      (state.resumeModel?.data?.hobbies?.length ?? 0) > 1
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: textWidget(
                                  text: AppStrings.hobbies,
                                  maxLines: 1,
                                  color: AppColors.textBlackColor,
                                  fontSize: AppDimensions.textSizeSmall,
                                  fontFamily: AppFont.gilroyBold,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox.shrink(),
                      (state.resumeModel?.data?.hobbies?.length ?? 0) > 1
                          ? height(0.02.sw)
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 8.0, // gap between lines
                          direction: Axis.horizontal,
                          children: [
                            for (int i = 0;
                                i <
                                    (state.resumeModel?.data?.hobbies?.length ??
                                        0);
                                i++)
                              FittedBox(
                                fit: BoxFit.cover,
                                child: Container(
                                  // width: .35.sw,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: textWidget(
                                      // text: itemsList[i],
                                      // text: _bloc.hobbies[i],
                                      text: state
                                          .resumeModel?.data?.hobbies?[i].hobby,
                                      maxLines: 2,
                                      color: AppColors.whiteColor,
                                      fontFamily: AppFont.gilroyMedium,
                                      fontSize:
                                          AppDimensions.textSizeVerySmall),
                                ),
                              )
                          ],
                        ),
                      ),
                      (state.resumeModel?.data?.hobbies?.length ?? 0) > 1
                          ? height(AppDimensions.formFieldsBetweenSpacing)
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.favoriteQuote,
                            maxLines: 1,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSizeSmall,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.01.sw),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, right: 8, bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.borderColorResumePage)),
                            child: textWidget(
                              // text: AppStrings.favoriteQuote,
                              text: state.resumeModel?.data?.favouriteQuote,
                              fontSize: AppDimensions.textSizeVerySmall,
                              fontFamily: AppFont.gilroyMedium,
                              maxLines: 1,
                            ),
                          )),
                      height(AppDimensions.formFieldsBetweenSpacing),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: textWidget(
                            text: AppStrings.whatDoYou,
                            maxLines: 1,
                            color: AppColors.textBlackColor,
                            fontSize: AppDimensions.textSizeSmall,
                            fontFamily: AppFont.gilroyBold,
                            fontWeight: FontWeight.bold),
                      ),
                      height(0.01.sw),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 1.sw,
                            padding: const EdgeInsets.only(
                                left: 12, top: 12, right: 8, bottom: 12),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.borderColorResumePage)),
                            child: textWidget(
                              // text: AppStrings.jobDescText,
                              text: state.resumeModel?.data?.description,
                              fontSize: AppDimensions.textSizeVerySmall,
                              fontFamily: AppFont.gilroyBold,
                              maxLines: 2,
                            ),
                          )),
                      height(AppDimensions.formFieldsBetweenSpacing),
                      state.resumeModel?.data?.file == null
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: textWidget(
                                      text: AppStrings.attachedResume,
                                      maxLines: 1,
                                      color: AppColors.textBlackColor,
                                      fontSize: AppDimensions.textSizeSmall,
                                      fontFamily: AppFont.gilroyBold,
                                      fontWeight: FontWeight.bold),
                                ),
                                height(AppDimensions.formFieldsBetweenSpacing),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: AppColors
                                                  .backIconBackgroundColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12))),
                                          child: Center(
                                              child: Image.asset(
                                            AssetsPath.pdf,
                                            width: 24,
                                            height: 24,
                                          )),
                                        ),
                                        width(0.04.sw),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textWidget(
                                                  // text: AppStrings.resumePdf + "djfj ssdjkjdksjkdjs kdjksjdkjskd jskdjksjd ksjdkjs",
                                                  text: state.resumeModel?.data
                                                      ?.filename,
                                                  fontFamily:
                                                      AppFont.gilroyBold,
                                                  fontSize: AppDimensions
                                                      .textSizeSmall,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.textBlackColor),
                                              height(0.002.sh),
                                              textWidget(
                                                // text: AppStrings.resumePdfSize,
                                                text: state.resumeModel?.data
                                                    ?.fileSize,
                                                fontFamily: AppFont.gilroyBold,
                                                fontSize:
                                                    AppDimensions.textSize10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        CustomMaterialButton(
                                            onPressed: () async {
                                              print(
                                                  "Pdf: ${state.resumeModel?.data?.file}");
                                              if (state.resumeModel?.data
                                                      ?.file !=
                                                  null) {
                                                await AppUtils.launchURL(
                                                    url: state.resumeModel!
                                                        .data!.file!);
                                              }
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (_) => PDFScreen(
                                              //             state
                                              //                 .resumeModel?.data?.file)));
                                            },
                                            width: 4,
                                            borderRadius: 14,
                                            name: AppStrings.view,
                                            fontSize:
                                                AppDimensions.textSizeVerySmall)
                                      ],
                                    )),
                              ],
                            ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

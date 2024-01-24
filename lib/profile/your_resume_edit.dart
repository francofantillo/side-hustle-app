import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as path;
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_font.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/assets_path.dart';
import 'package:side_hustle/utils/custom_icon_icons.dart';
import 'package:side_hustle/utils/service/file_picker_service.dart';
import 'package:side_hustle/utils/service/image_picker_service.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/circular_icon_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/buttons/icon_button_with_background.dart';
import 'package:side_hustle/widgets/images/circular_cache_image.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';
import 'package:side_hustle/widgets/text_field/textField.dart';

class YourResumeEdit extends StatefulWidget {
  final List? itemsList;
  final String? profileImagePath, pdfFilePath, pdfFileName;

  const YourResumeEdit(
      {super.key,
      this.itemsList,
      this.profileImagePath,
      this.pdfFilePath,
      this.pdfFileName});

  @override
  State<YourResumeEdit> createState() => _YourResumeEditState();
}

class _YourResumeEditState extends State<YourResumeEdit> {
  final _resumeKey = GlobalKey<FormState>();
  late final AuthCubit _bloc;
  File? _imagePath;
  String? _pdfFilePath, fileName;
  final TextEditingController _textEditingControllerHobbies =
      TextEditingController();

  // final List<String> itemsList = [
  //   "Hobbies 1",
  //   "Hobbies 2",
  //   "Hobbies 3",
  // ];
  late final List itemsList;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    itemsList = widget.itemsList ?? [];
    fileName = widget.pdfFileName;
    _bloc.initResumeControllers();
    _bloc.setResumeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.editYourResume,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 8),
          child: CircularIconButton(
            onPressed: () async {
              // Navigator.pop(context);
              FocusManager.instance.primaryFocus?.unfocus();
              if (_resumeKey.currentState!.validate()) {
                await _bloc.updateResumeCubit(
                    context: context,
                    mounted: mounted,
                    itemsList: itemsList,
                    pdfFile: _pdfFilePath,
                    profileImage: _imagePath);
              }
            },
            width: 0.10.sw,
            height: 0.10.sw,
            icon: CustomIcon.ok,
            backgroundColor: AppColors.backIconBackgroundColor,
            iconSize: 14,
            iconColor: AppColors.primaryColor,
          ),
        )
      ],
      body: Form(
        key: _resumeKey,
        child: SingleChildScrollView(
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
                    Stack(
                      children: [
                        CircularCacheImageWidget(
                          showLoading: true,
                          // image: AlphaAppData.dpProfile,
                          image: widget.profileImagePath,
                          fileImage: _imagePath?.path,
                          assetImage: AssetsPath.placeHolder,
                          boarderColor: AppColors.primaryColor,
                          imageHeight: 0.28.sw,
                          imageWidth: 0.28.sw,
                          borderWidth: .005.sw,
                        ),
                        Positioned(
                          left: 0.2.sw,
                          top: 0.2.sw,
                          child: IconButtonWithBackground(
                            height: .08.sw,
                            width: .08.sw,
                            borderRadius: 40,
                            backgroundColor: AppColors.primaryColor,
                            iconColor: AppColors.whiteColor,
                            iconSize: 14,
                            onTap: () async {
                              print("clicked minus");
                              _imagePath = await ImagePickerService
                                  .selectImageFromGallery();
                              if (_imagePath != null) {
                                print("image: ${_imagePath?.path}");
                                setState(() {});
                              }
                            },
                            iconPath: AssetsPath.edit,
                          ),
                        )
                      ],
                    ),
                    width(0.02.sw),
                    Container(
                      padding: const EdgeInsets.all(7.2),
                      decoration: const BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Row(
                        children: [
                          textWidget(
                              // text: AppStrings.uploadResume,
                              text: fileName ?? AppStrings.uploadResume,
                              color: AppColors.whiteColor,
                              fontFamily: AppFont.gilroyBold,
                              fontSize: AppDimensions.textSizeVerySmall),
                          width(0.015.sw),
                          Material(
                            color: AppColors.greenColor,
                            child: InkWell(
                              onTap: () async {
                                if (fileName == null) {
                                  _pdfFilePath =
                                      await FilePickerService.selectPDF();
                                  if (_pdfFilePath != null) {
                                    fileName = path.basename(_pdfFilePath!);
                                    // Check if the file exists
                                    if (File(_pdfFilePath!).existsSync()) {
                                      // File exists, proceed with operations
                                      int fileLength =
                                          File(_pdfFilePath!).lengthSync();
                                      print('File length: $fileLength');
                                    } else {
                                      print(
                                          'File does not exist at the specified path.');
                                    }
                                    setState(() {});
                                  }
                                } else {
                                  setState(() {
                                    fileName = null;
                                  });
                                }
                              },
                              child: Icon(
                                fileName != null
                                    ? CustomIcon.cancel
                                    : Icons.upload,
                                size: 24,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                height(0.08.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.actualName,
                      maxLines: 1,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.actualNameController,
                    height: 45.h,
                    hintText: AppStrings.actualNameHint,
                    // fillColor: AppColors.productTextFieldColor,
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.callSignOrNickname,
                      maxLines: 1,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.nickNameController,
                    height: 45.w,
                    hintText: AppStrings.callSignOrNicknameHint,
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing),
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
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.familyTiesController,
                    height: 45.h,
                    hintText: AppStrings.familyTiesHint,
                  ),
                ),
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
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.professionalBackgroundController,
                    height: 45.h,
                    hintText: AppStrings.professionalBackgroundHint,
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.profession,
                      maxLines: 1,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.professionController,
                    height: 45.h,
                    hintText: AppStrings.professionHint,
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: textWidget(
                      text: AppStrings.hobbies,
                      maxLines: 1,
                      color: AppColors.textBlackColor,
                      fontSize: AppDimensions.textSizeSmall,
                      fontFamily: AppFont.gilroyBold,
                      fontWeight: FontWeight.bold),
                ),
                height(0.01.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _textEditingControllerHobbies,
                    height: 45.h,
                    // inputFormatter: [
                    //   LengthLimitingTextInputFormatter(40),
                    // ],
                    hintText: AppStrings.hobbiesHint,
                    isSuffixIcon: true,
                    // suffixIcon: IconButton(
                    //   onPressed: () {
                    //     if (_textEditingControllerHobbies.text.isNotEmpty) {
                    //       itemsList.add(_textEditingControllerHobbies.text);
                    //       _textEditingControllerHobbies.clear();
                    //       setState(() {});
                    //     }
                    //   },
                    //   icon: Icon(
                    //     Icons.add,
                    //     color: AppColors.primaryColor,
                    //     size: 18,
                    //   ),
                    // ),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (_textEditingControllerHobbies.text.isNotEmpty) {
                          itemsList.add(_textEditingControllerHobbies.text);
                          _textEditingControllerHobbies.clear();
                          setState(() {});
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 8.0, // gap between lines
                    direction: Axis.horizontal,
                    children: <Widget>[
                      for (int i = 0; i < itemsList.length; i++)
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Container(
                            // width: .35.sw,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: textWidget(
                                      text: itemsList[i],
                                      maxLines: 2,
                                      color: AppColors.whiteColor,
                                      fontFamily: AppFont.gilroyMedium,
                                      fontSize:
                                          AppDimensions.textSizeVerySmall),
                                ),
                                width(0.015.sw),
                                Material(
                                  color: AppColors.primaryColor,
                                  child: InkWell(
                                    onTap: () {
                                      itemsList.removeAt(i);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      CustomIcon.cancel,
                                      color: AppColors.whiteColor,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing),
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
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.favouriteQuoteController,
                    height: 45.h,
                    hintText: AppStrings.favoriteQuoteHint,
                  ),
                ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: CustomTextFormField(
                    controller: _bloc.descriptionController,
                    height: 45.h,
                    hintText: AppStrings.whatDoYouHint,
                  ),
                ),
                height(AppDimensions.formFieldsBetweenSpacing + 0.02.sw),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomMaterialButton(
                      borderRadius: 14,
                      fontSize: AppDimensions.textSizeNormal,
                      // height: 10.h,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_resumeKey.currentState!.validate()) {
                          await _bloc.updateResumeCubit(
                              context: context,
                              mounted: mounted,
                              itemsList: itemsList,
                              pdfFile: _pdfFilePath,
                              profileImage: _imagePath);
                        }
                      },
                      color: AppColors.primaryColor,
                      name: AppStrings.saveResume),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

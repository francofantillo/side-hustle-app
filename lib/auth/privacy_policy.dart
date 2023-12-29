import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/state_management/cubit/auth/auth_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';
import 'package:side_hustle/widgets/text/text_widget.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late final AuthCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getPrivacyPolicy();
    super.initState();
  }

  getPrivacyPolicy() async {
    await _bloc.getTermsAndConditionsCubit(
        context: context, mounted: mounted, isTermsAndConditions: false);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        return state.termsAndConditions == null
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8),
                        child: textWidget(
                            text: AppStrings.privacyPolicy,
                            color: AppColors.blackColor,
                            fontSize: AppDimensions.textHeadingSizeHome,
                            fontWeight: FontWeight.bold),
                      ),
                      Html(
                        data: state.termsAndConditions,
                      ),
                      height(0.07.sw),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}

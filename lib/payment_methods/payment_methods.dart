import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/cart/modal_bottom_sheet/add_card.dart';
import 'package:side_hustle/payment_methods/widgets/payment_list.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/utils/app_utils.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/buttons/custom_material_button.dart';

class ManagePaymentMethods extends StatefulWidget {
  const ManagePaymentMethods({super.key});

  @override
  State<ManagePaymentMethods> createState() => _ManagePaymentMethodsState();
}

class _ManagePaymentMethodsState extends State<ManagePaymentMethods> {
  late final CardCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getCards();
    super.initState();
  }

  Future getCards() async {
    await _bloc.getCardsCubit(context: context, mounted: mounted);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.managePaymentMethods,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultHorizontalPadding + 4,
            vertical: AppDimensions.defaultHorizontalPadding),
        child: CustomMaterialButton(
          borderRadius: 16,
          textColor: AppColors.textWhiteColor,
          fontSize: AppDimensions.textSizeVerySmall,
          color: AppColors.primaryColor,
          onPressed: () {
            AppUtils.showBottomModalSheet(
                context: context, widget: AddCardModalSheet(bloc: _bloc));
          },
          name: AppStrings.addPaymentMethod,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<CardCubit, CardState>(builder: (context, state) {
        return (state.cardModel?.data?.isEmpty ?? true)
            ? const SizedBox.shrink()
            : const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentList(),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    )
                  ],
                ),
              );
      }),
    );
  }
}

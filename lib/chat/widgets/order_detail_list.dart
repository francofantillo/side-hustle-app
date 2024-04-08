import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/order_detail_item.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/utils/app_colors.dart';
import 'package:side_hustle/utils/app_dimen.dart';

class OrderDetailList extends StatefulWidget {
  const OrderDetailList({super.key});

  @override
  State<OrderDetailList> createState() => _OrderDetailListState();
}

class _OrderDetailListState extends State<OrderDetailList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
      return Expanded(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
          itemCount: state.orderDetailChatModel?.data?.length ?? 0,
          // Replace with your item count
          itemBuilder: (context, index) {
            // Replace with your horizontal list item
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8),
              child: OrderDetailItemWidget(
                imageWidth: 1.sw,
                imageHeight: AppDimensions.orderDetailHeight,
                boarderColor: AppColors.itemBGColor,
                // title: AppStrings.watch,
                title: state.orderDetailChatModel?.data?[index].productName,
                subTitle: "description needed",
                imagePath:
                    state.orderDetailChatModel?.data?[index].productImage,
                price: state.orderDetailChatModel?.data?[index]
                            .productPerPrice !=
                        null
                    ? "\$${state.orderDetailChatModel?.data?[index].productPerPrice}"
                    : "",
                onTap: () {},
              ),
            );
          },
        ),
      );
    });
  }
}

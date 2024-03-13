import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_hustle/chat/widgets/order_detail_list.dart';
import 'package:side_hustle/state_management/cubit/chat/chat_cubit.dart';
import 'package:side_hustle/utils/app_strings.dart';
import 'package:side_hustle/widgets/background_widget.dart';
import 'package:side_hustle/widgets/buttons/back_button.dart';
import 'package:side_hustle/widgets/size_widget.dart';

class OrderDetail extends StatefulWidget {
  final int? orderId;
  final bool isDelivery;

  const OrderDetail({super.key, this.isDelivery = true, this.orderId});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  late final ChatCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    getOrderDetails();
    super.initState();
  }

  getOrderDetails() async {
    await _bloc.getOrderDetailCubit(
        context: context, mounted: mounted, orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      showAppBar: true,
      appBarTitle: AppStrings.orderDetail,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child:
            backButton(onPressed: () => Navigator.pop(context), iconSize: 16),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
        return state.orderDetailLoading
            ? const SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(0.02.sw),
                  const OrderDetailList(),
                ],
              );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:side_hustle/payment_methods/widgets/payment_item.dart';
import 'package:side_hustle/state_management/cubit/card/card_cubit.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  late final CardCubit _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, CardState>(builder: (context, state) {
      return Expanded(
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: state.cardModel?.data?.length ?? 0,
          itemBuilder: (context, index) {
            return Padding(
                padding:
                    const EdgeInsets.only(right: 16.0, left: 8.0, bottom: 10),
                child: PaymentItem(
                  cardNumber: state.cardModel?.data?[index].last4,
                  defaultCard: (state.cardModel?.data?[index].isDefault ?? 0),
                  onChanged: (v) async {
                    await _bloc.defaultCardCubit(
                        context: context,
                        mounted: mounted,
                        cardId: state.cardModel?.data?[index].id);
                  },
                ));
          },
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:side_hustle/payment_methods/widgets/payment_item.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  int defaultCardIndex = 1;
  Map<String, List> defaultCard = {
    "x": [false, false],
  };

  @override
  void initState() {
    defaultCard = {
      "x": [false, true],
    };
    defaultCardIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // itemCount: AlphaAppData.jobsAndEventsList[0].itemList?.length ?? 0, // Replace with your item count
        itemCount: 2,
        // Replace with your item count
        itemBuilder: (context, index) {
          // Replace with your horizontal list item
          return Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, left: 8.0, bottom: 10),
              child: PaymentItem(
                defaultCard: defaultCard["x"]?[index],
                onChanged: (v) {
                  if(v ?? true) {
                    defaultCard["x"]?[defaultCardIndex] = false;
                    defaultCardIndex = index;
                    defaultCard["x"]?[index] = false;
                  } else {
                    defaultCard["x"]?[defaultCardIndex] = false;
                    defaultCardIndex = index;
                    defaultCard["x"]?[index] = true;
                  }
                  setState(() {});
                },
              ));
        },
      ),
    );
  }
}

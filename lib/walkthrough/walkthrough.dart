import 'package:flutter/material.dart';
import 'package:side_hustle/walkthrough/widgets/walkthrough_slider.dart';
import 'package:side_hustle/widgets/background_widget.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
        body: WillPopScope(
            onWillPop: onWillPop,
            child: const WalkthroughSlider())
    );
  }
}

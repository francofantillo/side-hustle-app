

import 'package:flutter/material.dart';
import 'package:side_hustle/widgets/app_drawer.dart';
import 'package:side_hustle/widgets/background_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const BackgroundWidget(
      drawer: AppDrawer(),
    );
  }
}

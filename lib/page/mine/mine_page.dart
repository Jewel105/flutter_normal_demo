import 'package:flutter/material.dart';
import 'package:hb_common/widget/hb_app_bar.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HbAppBar(
        titleName: "MinePage",
      ),
      body: Container(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hb_common/widget/hb_app_bar.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HbAppBar(
        titleName: "DemoPage",
      ),
      body: Container(),
    );
  }
}

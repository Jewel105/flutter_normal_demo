import 'package:flutter/material.dart';

import '../../widget/top_app_bar.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        titleName: "DemoPage",
      ),
      body: Container(),
    );
  }
}

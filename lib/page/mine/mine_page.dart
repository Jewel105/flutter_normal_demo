import 'package:flutter/material.dart';

import '../../widget/top_app_bar.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        titleName: "MinePage",
      ),
      body: Container(),
    );
  }
}

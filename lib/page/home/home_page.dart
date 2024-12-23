import 'package:flutter/material.dart';

import '../../widget/top_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        titleName: "HomePage",
      ),
      body: Container(),
    );
  }
}

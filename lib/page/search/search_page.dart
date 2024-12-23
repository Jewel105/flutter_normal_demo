import 'package:flutter/material.dart';

import '../../widget/top_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        titleName: "SearchPage",
      ),
      body: Container(),
    );
  }
}

import 'package:flutter/material.dart';

import 'home/home_page.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          HomePage(),
          Center(child: Text("Index Page!")),
        ],
      ),
    );
  }
}

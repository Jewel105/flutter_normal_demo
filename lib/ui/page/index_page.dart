import 'package:flutter/material.dart';
import 'package:flutter_normal_demo/ui/page/home/home_page.dart';

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

import 'package:flutter/material.dart';

import '../../widget/top_app_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(
          titleName: 'login',
        ),
        body: const Center(child: Text("login page")));
  }
}

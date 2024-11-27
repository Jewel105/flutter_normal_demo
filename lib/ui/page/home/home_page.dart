import 'package:flutter/material.dart';
import 'package:flutter_normal_demo/common/router/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        onPressed: () {
          Nav.push(Routes.login);
        },
        child: Text("login"),
      ),
    ));
  }
}

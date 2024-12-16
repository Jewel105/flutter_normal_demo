import 'package:flutter/material.dart';

import '../../core/extensions/index.dart';
import '../../core/router/index.dart';
import '../../widget/top_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(titleName: "home"),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Nav.push(Routes.login);
              },
              child: const Text("login"),
            ),
            Text(context.locale.home),
          ],
        ),
      ),
    );
  }
}

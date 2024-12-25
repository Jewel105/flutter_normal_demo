import 'package:flutter/material.dart';

import '../../core/extensions/context_extension.dart';
import '../../core/router/index.dart';
import '../../widget/main_button.dart';
import '../../widget/top_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        titleName: "HomePage",
      ),
      body: Column(
        children: [
          MainButton(
            textName: context.locale.add,
            onTap: () {
              Nav.push(
                Routes.demoPage,
                transitionType: TransitionType.none,
              );
            },
          ),
        ],
      ),
    );
  }
}

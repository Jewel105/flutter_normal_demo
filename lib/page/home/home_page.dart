import 'package:flutter/material.dart';

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
            textName: "Scan QR Code",
            onTap: () async {
              var qr = await Nav.push(Routes.scan);
              debugPrint('QR Code: $qr');
            },
          ),
          const MainButton(
            textName: "Disable Button",
          ),
          MainButton(
            textName: "switch language",
            onTap: () {
              Nav.push(Routes.language);
            },
          ),
        ],
      ),
    );
  }
}

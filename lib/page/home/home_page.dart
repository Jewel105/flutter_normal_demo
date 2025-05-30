import 'package:flutter/material.dart';
import 'package:hb_common/widget/index.dart';

import '../../core/router/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HbAppBar(
        titleName: "HomePage",
      ),
      body: Column(
        children: [
          HbButton(
            text: "Scan QR Code",
            onTap: () async {
              var qr = await Nav.push(Routes.scan);
              debugPrint('QR Code: $qr');
            },
          ),
          const HbButton(
            text: "Disable Button",
          ),
          HbButton(
            text: "switch language",
            onTap: () {
              Nav.push(Routes.language);
            },
          ),
        ],
      ),
    );
  }
}

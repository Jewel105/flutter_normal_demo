import 'package:flutter/material.dart';
import 'package:hb_common/widget/index.dart';
import 'package:hb_qr/page/hb_qr.dart';
import 'package:hb_router/utils/hb_nav.dart';

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
              var res = await HbQr.scan(context);
              print("res-----$res");
            },
          ),
          const HbButton(
            text: "Disable Button",
          ),
          HbButton(
            text: "switch language",
            onTap: () {
              HbNav.push(Routes.language);
            },
          ),
        ],
      ),
    );
  }
}

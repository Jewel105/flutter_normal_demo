import 'package:flutter/material.dart';
import 'package:hb_common/widget/hb_app_bar.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HbAppBar(
        titleName: "AddPage",
      ),
      body: Container(),
    );
  }
}

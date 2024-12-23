import 'package:flutter/material.dart';

import '../core/extensions/index.dart';
import './add/add_page.dart';
import './home/home_page.dart';
import './mine/mine_page.dart';
import './search/search_page.dart';
import 'index_logic.dart';
import 'index_state.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final IndexState indexState = IndexState();
  final IndexLogic indexLogic = IndexLogic();

  final pages = const [
    HomePage(),
    SearchPage(),
    AddPage(),
    MinePage(),
  ];

  get bottomItems {
    return [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home), label: context.locale.home),
      BottomNavigationBarItem(
          icon: const Icon(Icons.search), label: context.locale.search),
      BottomNavigationBarItem(
          icon: const Icon(Icons.add), label: context.locale.add),
      BottomNavigationBarItem(
          icon: const Icon(Icons.person), label: context.locale.mine),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: indexState.pageController,
        onPageChanged: indexLogic.handlePageChanged,
        children: pages,
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: indexState.pageIndex,
          builder: (context, pageIndex, _) {
            return BottomNavigationBar(
              currentIndex: pageIndex,
              onTap: indexLogic.handleNavBarTap,
              items: bottomItems,
            );
          }),
    );
  }
}

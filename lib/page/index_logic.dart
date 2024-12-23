import 'index_state.dart';

class IndexLogic {
  final IndexState state = IndexState();

  // page changed event handler
  void handlePageChanged(int index) {
    state.pageIndex.value = index;
  }

  // bottom navigation bar tap event handler
  void handleNavBarTap(int index) {
    state.pageController.jumpToPage(index);
  }

  // Single instance
  IndexLogic._internal();
  static final IndexLogic _instance = IndexLogic._internal();
  factory IndexLogic() => _instance;
}

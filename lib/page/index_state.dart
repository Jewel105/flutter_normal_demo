import 'package:flutter/material.dart';

class IndexState {
  final PageController pageController = PageController();

  // index of the current page
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  // Single instance
  IndexState._internal();
  static final IndexState _instance = IndexState._internal();
  factory IndexState() => _instance;
}

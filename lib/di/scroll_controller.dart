import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyScrollController {
  final ScrollController _scrollController = ScrollController();

  ScrollController getScrollController() => _scrollController;
}

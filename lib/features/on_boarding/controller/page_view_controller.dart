import 'package:flutter/material.dart';

class PageViewController {
  final PageController _controller = PageController();

  PageController get controller => _controller;

  void navigateToNextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void navigateToPreviousPage() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skipToLastPage(int targetPage) {
    _controller.jumpToPage(targetPage);
  }

  void dispose() {
    _controller.dispose();
  }
}

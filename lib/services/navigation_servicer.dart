import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigateTo(Widget widget) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  navigateToAndRemove(Widget widget) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }

  navigateToReplace(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<void> showDialog(Widget widget) async {
    await showAdaptiveDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentMaterialBanner();
    final snackbarWidget = SnackBar(content: Text(message, style: TextStyle(color: Colors.white),));
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackbarWidget);
  }
}

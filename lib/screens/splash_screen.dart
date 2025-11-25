import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/widgets/my_error_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyErrorWidget(
          errorMessage: "Something went wrong!",
          retryFunction: () {},
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_colors.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.errorMessage,
    required this.retryFunction,
  });

  final String errorMessage;
  final Function() retryFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(MyAppIcons.errorIcon,color: MyAppColors.redColor,size: 50,),
          const SizedBox(height: 20),
          Text(
            "Error $errorMessage",
            style: const TextStyle(
              color: MyAppColors.redColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => retryFunction(),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyAppColors.whiteColor,
            ),
            child: Text("Retry", style: TextStyle(color: MyAppColors.greyColor),),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../constants/my_app_colors.dart';
import '../constants/my_app_icons.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key, required this.isFavorite, required this.onPressed});
  final bool isFavorite;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteBorder),
      color: isFavorite ? MyAppColors.redColor : MyAppColors.greyColor,
      onPressed: onPressed,
    );
  }
}

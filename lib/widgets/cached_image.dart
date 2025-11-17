import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';

import '../constants/my_app_colors.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({super.key, required this.imageUrl, required this.height, required this.width, required this.fit});
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return CachedNetworkImage(
      imageUrl: imageUrl ?? 'https://m.media-amazon.com/images/I/81dae9nZFBS._AC_UF894,1000_QL80_.jpg',
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(MyAppIcons.errorIcon, size: 50, color: MyAppColors.redColor),
      fit: fit ?? BoxFit.cover,
      height: height ?? size.width * 0.3,
      width: width ?? size.width * 0.2,
    );
  }
}

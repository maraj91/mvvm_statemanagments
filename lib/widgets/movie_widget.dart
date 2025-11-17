import 'package:flutter/material.dart';

import '../constants/my_app_colors.dart';
import '../constants/my_app_icons.dart';
import 'cached_image.dart';
import 'favorite_widget.dart';
import 'genres_list_widget.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicWidth(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedImage(
                    imageUrl: 'https://m.media-amazon.com/images/I/81dae9nZFBS._AC_UF894,1000_QL80_.jpg',
                    height: 100,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Movie Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(MyAppIcons.star, color: MyAppColors.startColor,size: 20,),
                        Text('4.5'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const GenresListWidget(),
                    Row(
                      children: [
                        const Icon(MyAppIcons.date, color: MyAppColors.blue,size: 20,),
                        const SizedBox(width: 8),
                        const Text('Release date'),
                        const Spacer(),
                        FavoriteWidget(isFavorite: false, onPressed: () {

                        }),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

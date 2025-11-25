import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/screens/movies_screen.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagments/view_models/movies_provider.dart';
import 'package:mvvm_statemanagments/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialdata(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(context.mounted) {
        await Provider.of<MoviesProvider>(context, listen: false).fetchMovies();
      }
      if(context.mounted) {
        await Provider.of<FavoritesProvider>(context, listen: false).loadFavorites();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _loadInitialdata(context),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return MyErrorWidget(
                errorMessage: "Something went wrong!",
                retryFunction: () {},
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                getIt<NavigationService>().navigateToReplace(MoviesScreen());
              });
              return const SizedBox.shrink();
            }
          },)
      // Center(
      //   child: MyErrorWidget(
      //     errorMessage: "Something went wrong!",
      //     retryFunction: () {},
      //   ),
      // ),
    );
  }
}


import 'package:get_it/get_it.dart';
import 'package:mvvm_statemanagments/repository/movies_repository.dart';
import 'package:mvvm_statemanagments/services/api_service.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/view_models/theme_provider.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(() => MoviesRepository(getIt<ApiService>()));
  // getIt.registerLazySingleton<ThemeProvider>(() => Provider.of<ThemeProvider>(context));
}
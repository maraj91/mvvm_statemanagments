import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mvvm_statemanagments/screens/favorites_screen.dart';
import 'package:mvvm_statemanagments/screens/movies_details.dart';
import 'package:mvvm_statemanagments/screens/movies_screen.dart';
import 'package:mvvm_statemanagments/screens/splash_screen.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/widgets/my_error_widget.dart';

import 'constants/my_theme_data.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(MyApp());
  },);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.getLightTheme(),
      darkTheme: MyThemeData.getDarkTheme(),
      themeMode: ThemeMode.system,
      home: const MoviesScreen(),
    );
  }
}

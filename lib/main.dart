import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/screens/movies_details.dart';

import 'constants/my_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.getLightTheme(),
      darkTheme: MyThemeData.getDarkTheme(),
      themeMode: ThemeMode.system,
      home: const MoviesDetails(),
      // home: const MoviesScreen(),
    );
  }
}

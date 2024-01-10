import 'package:flutter/material.dart';
import 'package:yesmachinery/src/features/splash_screen/screens/splash_screen.dart';
import 'package:yesmachinery/src/utils/theme/theme.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sales App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: YAppTheme.darkTheme,
      theme: YAppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

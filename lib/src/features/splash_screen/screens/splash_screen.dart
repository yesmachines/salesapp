import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesmachinery/src/features/authentication/screens/login.dart';
import 'package:yesmachinery/src/features/home/screens/navigation_menu.dart';
import 'package:yesmachinery/src/utils/app_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConfig.acessToken);

      if (token != null && token.isNotEmpty) {
        Get.off(() => const NavigationMenu());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/neo_new.png",
          height: size.height * 0.3,
        ),
      ),
    );
  }
}

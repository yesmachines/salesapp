import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yesmachinery/src/features/home/screens/navigation_menu.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';
import 'package:yesmachinery/src/utils/app_config.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isVisible = true.obs;
  RxBool isPostLoading = false.obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    isPostLoading.value = true;

    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginUrl);
      Map body = {"email": emailController.text.trim(), "password": passwordController.text};

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"]) {
          var token = json["data"]["token"];
          var userid = json["data"]["userid"];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString(AppConfig.acessToken, token);
          await prefs.setString("userid", userid.toString());
          await prefs.setString("login_email", emailController.text.trim());

          emailController.clear();
          passwordController.clear();
          Get.off(const NavigationMenu());
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown error occurred";
      }
    } catch (e) {
      isPostLoading.value = false;

      // Show snackbar with the erro message
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  onVisibilityPresses() {
    isVisible.toggle();
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController useridController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveUserProfileForm() async {
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.enquiryEndPoints.enquiryUrl);
      //print(url);
      Map body = {
        "name": nameController.text.trim(),
        "password": passwordController.text.trim(),
        "userid": useridController.text.trim()
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        //  print(json);
        if (json["success"]) {
          //  print(json["data"]);
          nameController.clear();
          passwordController.clear();
          useridController.clear();

          Get.back();
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown error occured";
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

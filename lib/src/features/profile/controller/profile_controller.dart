import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';
import 'package:yesmachinery/src/features/profile/models/user_profile.dart';

class ProfileController extends GetxController {
  Map<String, dynamic> userProfile = {};

  var isLoading = false.obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> userid;
  late Future<String> headerToken;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final SharedPreferences prefs = await _prefs;
    final String? userid = prefs.getString('userid');
    final String? headerToken = prefs.getString('token');

    isLoading.value = true;
    try {
      var headToken = "Bearer :token";
      headToken = headToken.replaceAll(":token", headerToken.toString());

      // Try reading data from the 'counter' key. If it doesn't exist, returns null.
      var headers = {"Content-Type": "application/json", "Authorization": headToken};

      String profileEndUrl = ApiEndPoints.profileEndPoints.profileUrl;
      profileEndUrl = profileEndUrl.replaceAll(":id", userid.toString());
      var url = Uri.parse(ApiEndPoints.baseUrl + profileEndUrl);

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"]) {
          userProfile = json["data"];

          isLoading.value = false;
          update();
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/home/models/divisions.dart';
import 'dart:convert';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class DashboardController extends GetxController {
  var divisionList = [].obs;
  var isLoading = false.obs;

  Future<void> fetchDivisions() async {
    isLoading.value = true;
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.divisionEndPoints.divisionUrl);

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"]) {
          final List result = json["data"];
          divisionList.value = result.map((e) => Divisions.fromJson(e)).toList();
          print(divisionList.length);
          isLoading.value = false;
          update();
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown error occured";
      }
    } catch (e) {
      isLoading.value = false;
      // Show snackbar with the erro message
      Get.snackbar(
        "",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

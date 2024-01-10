import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class EnquiryController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController productController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> sendEnquiryForm() async {
    isLoading.value = true;
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.enquiryEndPoints.enquiryUrl);
      //print(url);
      Map body = {
        "name": nameController.text.trim(),
        "company": companyController.text.trim(),
        "email": emailController.text.trim(),
        "mobile": phoneController.text.trim(),
        "message": messageController.text.trim(),
        "product": productController.text.trim()
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        //  print(json);
        if (json["success"]) {
          //  print(json["data"]);
          nameController.clear();
          companyController.clear();
          emailController.clear();
          phoneController.clear();
          messageController.clear();
          productController.clear();

          isLoading.value = false;
          Get.snackbar(
            'Success',
            json["message"] ?? "Your enquiry submitted",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown error occured";
      }
    } catch (e) {
      Get.snackbar(
        'Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoading.value = false;
      print(e.toString());
    }
  }
}

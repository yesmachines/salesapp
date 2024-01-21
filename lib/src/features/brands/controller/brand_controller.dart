import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/brands/models/suppliers.dart';
import 'dart:convert';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class BrandController extends GetxController {
  var supplierList = List<BrandSuppliersResModel>.empty().obs;
  var isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();

  // }

  // updateID(var divid) {
  //   divisionId = divid;
  //   fetchSuppliers(divisionId: divisionId);
  // }

  void fetchSuppliers({required String divisionId, bool isyc = false}) async {
    isLoading.value = true;
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.brandEndPoints.brandUrl}?division=$divisionId${isyc == true ? ("&is_yc=$isyc") : ""}");
      // log(url.toString());
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // log(json.toString());
        if (json["success"]) {
          final List result = json["data"];
          supplierList.value = result.map((e) => BrandSuppliersResModel.fromJson(e)).toList();
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
      // Get.back();
    }
  }
}

import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/products/models/product.dart';
import 'dart:convert';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class ProductController extends GetxController {
  var productList = List<Product>.empty().obs;
  var isLoading = false.obs;
  // var brandid;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchProducts(brandid);
  // }

  // updateID(var bid) {
  //   brandid = bid;
  //   //// print('im print ${bid}');
  //   fetchProducts(brandid: brandid);
  // }

  Future<void> fetchProducts({required String brandid, bool isyc = false}) async {
    isLoading.value = true;
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.productEndPoints.productUrl}?brand_id=$brandid${isyc == true ? ("&is_yc=$isyc") : ""}");
      // log(url.toString());

      // var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.productUrl + "?brand_id=" + brandid);

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"]) {
          final List result = json["data"];
          //// print(result.runtimeType);
          productList.value = result.map((e) => Product.fromJson(e)).toList();
          // // print(productList.runtimeType);
          isLoading.value = false;
          update();
        } else {
          throw jsonDecode(response.body)["message"];
        }
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown error occured";
      }
    } catch (e) {}
  }
}

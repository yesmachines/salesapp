import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yesmachinery/src/features/products/models/product.dart';
import 'dart:convert';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class SearchpageController extends GetxController {
  var isLoading = true.obs;
  // List<Map<String, dynamic>> allproducts = [];
  var allproducts = List<Product>.empty().obs;

  var foundProduct = List<Product>.empty().obs;

  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }

  void filterProduct(String prodName) {
    var results = List<Product>.empty();
    if (prodName.isEmpty) {
      results = allproducts;
    } else {
      results = allproducts
          .where((element) => element.name.toString().toLowerCase().contains(prodName.toLowerCase()))
          .toList();
    }
    foundProduct.value = results;
  }

  Future<void> fetchAllProducts() async {
    isLoading.value = true;
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.productUrl);

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"]) {
          final List result = json["data"];
          allproducts.value = result.map((e) => Product.fromJson(e)).toList();

          foundProduct.value = allproducts;

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

      // rethrow;
    }
  }
}

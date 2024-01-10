import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/productdetails/models/product_detail.dart';
import 'dart:convert';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class ProductDetailController extends GetxController {
  List<Map<String, dynamic>> productBanners = [];
  List<Map<String, dynamic>> applicationImages = [];
  List<Map<String, dynamic>> productImages = [];
  List<Map<String, dynamic>> productVideos = [];
  List<Map<String, dynamic>> productCatalog = [];

  var productId;
  var isLoading = false.obs;

  late Product productDetail;

  @override
  void onInit() {
    super.onInit();

    fetchProductDetails();
  }

  updateID(var prodId) {
    productId = prodId;

    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    isLoading.value = true;
    try {
      var headers = {"Content-Type": "application/json"};
      String productEndUrl = ApiEndPoints.productEndPoints.productViewUrl;
      productEndUrl = productEndUrl.replaceAll(":id", productId.toString());
      var url = Uri.parse(ApiEndPoints.baseUrl + productEndUrl);
      //  print(url);
      // print('Inside function ${productId}');
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["success"]) {
          //  print( json["data"]["product"]);
          //  print(json["data"]["product"]);
          productDetail = Product.fromJson(json["data"]["product"]);
          // print(productDetail.runtimeType);

          final List bresult = json["data"]["productBanners"];
          //  print(bresult.length);
          // productBanners = bresult.map((e) =>AppImage.fromJson(e)).toList();
          if (bresult.isNotEmpty) {
            productBanners = bresult.map((s) => {'image_url': s["image_url"], 'title': s["title"]}).toList();
          }
          // print(productBanners);

          final List aresult = json["data"]["appImages"];
          if (aresult.isNotEmpty) {
            applicationImages = aresult.map((s) => {'image_url': s["image_url"], 'title': s["title"]}).toList();
          }
          // print(applicationImages);

          final List presult = json["data"]["productImages"];
          if (presult.isNotEmpty) {
            productImages = presult.map((s) => {'image_url': s["image_url"], 'title': s["title"]}).toList();
          }
          // print(productImages);

          final List vresult = json["data"]["productVideos"];
          if (vresult.isNotEmpty) {
            productVideos = vresult.map((s) => {'video_url': s["video_url"], 'title': s["title"]}).toList();
          }
          //  print(productVideos);

          final List catalogResult = json["data"]["productCatelogues"];
          if (catalogResult.isNotEmpty) {
            productCatalog = catalogResult.map((s) => {'catalogue': s["catalogue"], 'title': s["title"]}).toList();
          }
          // print(productCatalog);
          //  print("SUCCESS");
          //
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

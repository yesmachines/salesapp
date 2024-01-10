import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/productdetails/screens/product_detail.dart';
import 'package:yesmachinery/src/features/products/controller/product_controller.dart';
import 'package:yesmachinery/src/features/products/models/product.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';
import 'package:yesmachinery/src/features/home/screens/search.dart';

class ProductLists extends StatefulWidget {
  //const ProductLists({Key? key}) : super(key: key);
  final String brandid;
  const ProductLists({Key? key, required this.brandid}) : super(key: key);

  @override
  State<ProductLists> createState() => _ProductListsState();
}

class _ProductListsState extends State<ProductLists> {
  final ProductController productcontroller = Get.put(ProductController());
  String rootPath = ApiEndPoints.imageRootPath;
  List<Product> productList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await productcontroller.updateID(widget.brandid);
      productList = productcontroller.productList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ), // simple as that!
        title: const Text('PRODUCTS'),
        centerTitle: true,
        elevation: 2.0,
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search)),
          // TextButton(
          //     onPressed: () async {
          //       final SharedPreferences? prefs = await _prefs;
          //       prefs?.clear();
          //       Get.offAll(Login());
          //     },
          //     child: Icon(Icons.logout))
        ],
      ),
      body: Obx(
        () => productcontroller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (productList.isNotEmpty)
                ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // number of items in each row
                        mainAxisSpacing: 15.0, // spacing between rows
                        crossAxisSpacing: 20.0, // spacing between columns
                        mainAxisExtent: 200.0),
                    padding: const EdgeInsets.all(10.0), // padding around the grid
                    itemCount: productList.length, // total number of items
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductDetailsScreen(productid: productList[index].id.toString()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                                child: CommonImageView(
                                  url: "$rootPath${productList[index].defaultImage}",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 120.0,
                                ),
                              ),
                              Text(
                                productList[index].name ?? "",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                    "Empty Data",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  )),
      ),
    );
  }
}

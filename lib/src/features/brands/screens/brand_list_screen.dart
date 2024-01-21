import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/brands/models/suppliers.dart';
import 'package:yesmachinery/src/features/brands/controller/brand_controller.dart';
import 'package:yesmachinery/src/features/home/screens/search.dart';
import 'package:yesmachinery/src/features/products/screens/product_lists.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class BrandListScreen extends StatefulWidget {
//  const Brand({Key? key}) : super(key: key);
  final String divisionId;
  const BrandListScreen({Key? key, required this.divisionId}) : super(key: key);

  @override
  State<BrandListScreen> createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  bool isyc = false;
  final BrandController brandcontroller = Get.put(BrandController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.divisionId.toLowerCase() == "yc") {
        isyc = true;
        brandcontroller.fetchSuppliers(divisionId: widget.divisionId, isyc: true);
      } else {
        brandcontroller.fetchSuppliers(divisionId: widget.divisionId, isyc: false);
      }

      supplierList = brandcontroller.supplierList;
    });

    super.initState();
  }

  List<BrandSuppliersResModel> supplierList = [];

  String rootPath = '';
  @override
  Widget build(BuildContext context) {
    if (widget.divisionId.toLowerCase() == "yc") {
      rootPath = ApiEndPoints.ycImageRootPath;
    } else {
      rootPath = ApiEndPoints.imageRootPath;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('SUPPLIERS'),
        centerTitle: true,
        elevation: 2.0,
        actions: [
          // Navigate to the Search Screen
          IconButton(onPressed: () => Get.to(() => const SearchPage()), icon: const Icon(Icons.search)),
        ],
      ),
      body: Obx(
        () => brandcontroller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : (supplierList.isNotEmpty)
                ? GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 3,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(supplierList.length, (index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductLists(
                                brandid: supplierList[index].id.toString(),
                                isYc: isyc,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 140,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.grey.shade300),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white, Colors.white70],
                                  ),
                                  // borderRadius: BorderRadius.all(Radius.circular(3)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1),
                                  child: CommonImageView(
                                      fit: BoxFit.contain, url: rootPath + (supplierList[index].logoUrl ?? "")),
                                ),
                              ),
                              Text(
                                supplierList[index].brand ?? "",
                                style: Theme.of(context).textTheme.bodyText2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                : Center(
                    child: Text(
                    "No Data Found",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  )),
      ),
    );
  }
}

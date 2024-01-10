import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yesmachinery/src/features/home/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/productdetails/controller/product_detail_controller.dart';
import 'package:yesmachinery/src/features/productdetails/screens/application_images.dart';
import 'package:yesmachinery/src/features/productdetails/screens/catalogs.dart';
import 'package:yesmachinery/src/features/productdetails/screens/videos_list_screen.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:yesmachinery/src/features/productdetails/screens/enquiry.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key, required this.productid}) : super(key: key);

  final String productid;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with TickerProviderStateMixin {
  int selectedImage = 0;
  String rootPath = ApiEndPoints.imageRootPath;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ProductDetailController productdetailcontroller = Get.put(ProductDetailController());

  @override
  void initState() {
    productdetailcontroller.productId = widget.productid;
    productdetailcontroller.updateID(widget.productid);
    //  print("Screen Initial ${widget.productid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ), // simple as that!
        title: const Text('PRODUCT DETAILS'),
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
        () => productdetailcontroller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : (productdetailcontroller.productDetail?.id != null)
                ? ListView(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12.0),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildProductImagesWidgets(
                              (productdetailcontroller.productBanners.isNotEmpty)
                                  ? productdetailcontroller.productBanners
                                  : [],
                              rootPath),
                          // SizedBox(
                          //     width: 240.0,
                          //     child: AspectRatio(
                          //       aspectRatio: 1,
                          //       child: Image.network(productGallery[selectedImage]),
                          //     )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  productdetailcontroller.productDetail.name ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  productdetailcontroller.productDetail.category ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "By : ${productdetailcontroller.productDetail.brand}, ${productdetailcontroller.productDetail.country}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ApplicationImages(
                                      applicationImages: productdetailcontroller.applicationImages.isNotEmpty
                                          ? productdetailcontroller.applicationImages
                                          : [],
                                      productImages: productdetailcontroller.productImages.isNotEmpty
                                          ? productdetailcontroller.productImages
                                          : []);
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                height: 40.0,
                                width: 85.0,
                                color: Colors.lightGreen,
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return VideosListScreen(
                                      key: UniqueKey(),
                                      productVideos: productdetailcontroller.productVideos.isNotEmpty
                                          ? productdetailcontroller.productVideos
                                          : []);
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                height: 40.0,
                                width: 85.0,
                                color: Colors.lightGreen,
                                child: Icon(
                                  Icons.video_camera_back,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return ProductCatalogScreen(
                                      key: UniqueKey(),
                                      productCatalog: productdetailcontroller.productCatalog.isNotEmpty
                                          ? productdetailcontroller.productCatalog
                                          : []);
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                height: 40.0,
                                width: 85.0,
                                color: Colors.lightGreen,
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Lists");
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.0),
                                height: 40.0,
                                width: 85.0,
                                color: Colors.lightGreen,
                                child: Icon(
                                  Icons.list,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            )
                          ]),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Text(
                              "Product Highlights",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ]),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(child: Html(data: productdetailcontroller.productDetail.description ?? "")),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                //   _ShowExpressInterestPopup(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return EnquiryScreen(
                                      key: UniqueKey(), product: productdetailcontroller.productDetail.name ?? "");
                                }));
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.lightGreen,
                              ),
                              child: Text(
                                "EXPRESS INTEREST",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ],
                    //),
                  )
                : Center(
                    child: Text(
                    "Empty Data",
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  )),
      ),
    );
  }

  _buildProductImagesWidgets(List banners, rootPath) {
    TabController imagesController = TabController(length: banners.length, vsync: this);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: banners.isNotEmpty
            ? SizedBox(
                height: 250.0,
                child: Center(
                  child: DefaultTabController(
                    length: banners.length,
                    child: Stack(
                      children: <Widget>[
                        TabBarView(
                          controller: imagesController,
                          children: List.generate(banners.length, (int index) {
                            return CommonImageView(url: rootPath + banners[index]['image_url']);
                          }),
                        ),
                        Container(
                          alignment: FractionalOffset(0.5, 0.95),
                          child: TabPageSelector(
                            controller: imagesController,
                            selectedColor: Colors.grey,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                height: 250.0,
                width: double.infinity,
                child: Image.asset(
                  "assets/no-image-available.jpg",
                  fit: BoxFit.cover,
                )));
  }

  // _ShowExpressInterestPopup(context){
  //   EnquiryController enquiryController = Get.put(EnquiryController());
  //   final _formKey = GlobalKey<FormState>();
  //
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         scrollable: true,
  //         title: const Text("EXPRESS INTEREST"),
  //         content: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Form(
  //             key: _formKey,
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   controller: enquiryController.nameController,
  //                   validator: (value) {
  //                     if (value == null || value.trim().isEmpty) {
  //                       return 'Please enter name';
  //                     }
  //                     return null;
  //                   },
  //                   decoration: const InputDecoration(
  //                       labelText: "Full Name",
  //                       prefixIcon: Icon(Icons.account_box),
  //                       border: OutlineInputBorder()),
  //                 ),
  //                 SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 TextFormField(
  //                   controller: enquiryController.companyController,
  //                   decoration: const InputDecoration(
  //                       labelText: "Company",
  //                       prefixIcon: Icon(Icons.business),
  //                       border: OutlineInputBorder()),
  //                 ),
  //                 SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 TextFormField(
  //                   controller: enquiryController.emailController,
  //                   validator: (value) {
  //                     if (value == null || value.trim().isEmpty) {
  //                       return 'Please enter email';
  //                     }
  //                     return null;
  //                   },
  //                   decoration: const InputDecoration(
  //                       labelText: "Customer Email",
  //                       prefixIcon: Icon(Icons.email),
  //                       border: OutlineInputBorder()),
  //                 ),
  //                 SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 TextFormField(
  //                   controller: enquiryController.phoneController,
  //                   validator: (value) {
  //                     if (value == null || value.trim().isEmpty) {
  //                       return 'Please enter phone number';
  //                     }
  //                     return null;
  //                   },
  //                   decoration: const InputDecoration(
  //                       labelText: "Contact Number",
  //                       prefixIcon: Icon(Icons.phone),
  //                       border: OutlineInputBorder()),
  //                 ),
  //                 SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 TextFormField(
  //                   controller: enquiryController.messageController,
  //                   maxLines: null,
  //                   minLines: 2,
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: const InputDecoration(
  //                     labelText: "Message",
  //                     prefixIcon: Icon(Icons.message),
  //                     border: OutlineInputBorder(),
  //                     hintText: "Enter your requirement here",
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10.0,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             style: OutlinedButton.styleFrom(
  //               foregroundColor: Colors.white,
  //               backgroundColor: Colors.lightGreen,),
  //             child: const Text("SEND ENQUIRY"),
  //             onPressed: () {
  //
  //               enquiryController.sendEnquiryForm();
  //               // your code
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

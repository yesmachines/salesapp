import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yesmachinery/src/features/productdetails/screens/pdf_viewwer_screen.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductCatalogScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productCatalog;
  String rootPath = ApiEndPoints.imageRootPath;

  ProductCatalogScreen({required Key key, required this.productCatalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ), // simple as that!
        title: const Text('Product Catalog'),
        elevation: 2.0,
      ),
      body: (productCatalog.length > 0)
          ? Column(
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 15.0, // spacing between rows
                          crossAxisSpacing: 20.0, // spacing between columns
                          mainAxisExtent: 180.0),
                      padding: EdgeInsets.all(10.0), // padding around the grid
                      itemCount: productCatalog.length, // total number of items
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: Colors.black12),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: SfPdfViewer.network(rootPath + productCatalog[index]['catalogue']),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.to(
                                          () => PdfViewerScreen(pdfUrl: rootPath + productCatalog[index]['catalogue']));
                                    },
                                    icon: const Icon(Icons.fullscreen)),
                                IconButton(
                                    onPressed: () async {
                                      await Share.share(
                                          'check out our product Catalog ${rootPath + productCatalog[index]['catalogue']}');
                                    },
                                    icon: const Icon(Icons.share))
                              ],
                            )
                          ],
                        );
                      }),
                ),
              ],
            )
          : Center(child: Text("No Catalog")),
    );
  }
}

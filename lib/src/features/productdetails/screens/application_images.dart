import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class ApplicationImages extends StatelessWidget {
  final List<Map<String, dynamic>> productImages;
  final List<Map<String, dynamic>> applicationImages;
  final String rootPath = ApiEndPoints.imageRootPath;

  ApplicationImages({required this.productImages, required this.applicationImages});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Images'),
          elevation: 2.0,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Product Images'),
              Tab(text: 'Application Images'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ImageGrid(images: productImages),
            ImageGrid(images: applicationImages),
          ],
        ),
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  final List<Map<String, dynamic>> images;
  final String rootPath = ApiEndPoints.imageRootPath;

  ImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    return (images.isNotEmpty)
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 20.0,
              mainAxisExtent: 180.0,
            ),
            padding: const EdgeInsets.all(10.0),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      CommonImageView(
                        url: rootPath + images[index]['image_url'],
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          images[index]['title'],
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (_) => ImageDialog(rootPath + images[index]['image_url']),
                  );
                },
              );
            },
          )
        : const Center(child: Text("No Images"));
  }
}

class ImageDialog extends StatelessWidget {
  final String? imageLink;

  const ImageDialog(this.imageLink);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * .60,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                imageLink != null
                    ? PhotoView(
                        backgroundDecoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        imageProvider: NetworkImage(imageLink!),
                      )
                    : CommonImageView(
                        url: imageLink.toString(),
                        fit: BoxFit.contain,
                      ),
                Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ))
              ],
            )));

    // Dialog(
    //   child: Container(
    //     width: 250,
    //     height: 250,
    //     decoration: BoxDecoration(
    //       boxShadow: const [
    //         BoxShadow(
    //           color: Colors.black,
    //           offset: Offset(5.0, 5.0),
    //           blurRadius: 10.0,
    //           spreadRadius: 2.0,
    //         ),
    //         BoxShadow(
    //           color: Colors.white,
    //           offset: Offset(0.0, 0.0),
    //           blurRadius: 0.0,
    //           spreadRadius: 0.0,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

// class ProductDetail {
//   Product product;
//   List<AppImage> productImages;
//   List<AppImage> productBanners;
//   List<ProductVideo> productVideos;
//   List<AppImage> appImages;
//   List<ProductCatelogue> productCatelogues;

//   ProductDetail({
//     required this.product,
//     required this.productImages,
//     required this.productBanners,
//     required this.productVideos,
//     required this.appImages,
//     required this.productCatelogues,
//   });

//   factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
//     product: Product.fromJson(json["product"]),
//     productImages: List<AppImage>.from(json["productImages"].map((x) => AppImage.fromJson(x))),
//     productBanners: List<AppImage>.from(json["productBanners"].map((x) => AppImage.fromJson(x))),
//     productVideos: List<ProductVideo>.from(json["productVideos"].map((x) => ProductVideo.fromJson(x))),
//     appImages: List<AppImage>.from(json["appImages"].map((x) => AppImage.fromJson(x))),
//     productCatelogues: List<ProductCatelogue>.from(json["productCatelogues"].map((x) => ProductCatelogue.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "product": product.toJson(),
//     "productImages": List<dynamic>.from(productImages.map((x) => x.toJson())),
//     "productBanners": List<dynamic>.from(productBanners.map((x) => x.toJson())),
//     "productVideos": List<dynamic>.from(productVideos.map((x) => x.toJson())),
//     "appImages": List<dynamic>.from(appImages.map((x) => x.toJson())),
//     "productCatelogues": List<dynamic>.from(productCatelogues.map((x) => x.toJson())),
//   };
// }

// class AppImage {
//   int id;
//   int productId;
//   String imageUrl;
//   String imageType;
//   String title;
//   int priority;

//   AppImage({
//     required this.id,
//     required this.productId,
//     required this.imageUrl,
//     required this.imageType,
//     required this.title,
//     required this.priority,
//   });

//   factory AppImage.fromJson(Map<String, dynamic> json) => AppImage(
//     id: json["id"],
//     productId: json["product_id"],
//     imageUrl: json["image_url"],
//     imageType: json["image_type"],
//     title: json["title"],
//     priority: json["priority"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "image_url": imageUrl,
//     "image_type": imageType,
//     "title": title,
//     "priority": priority,
//   };
// }

// class Product {
//   int id;
//   String name;
//   String subtitle;
//   String description;
//   String category;
//   String brand;
//   String country;

//   Product({
//     required this.id,
//     required this.name,
//     required this.subtitle,
//     required this.description,
//     required this.category,
//     required this.brand,
//     required this.country
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     subtitle: json["subtitle"],
//     description: json["description"],
//     category: json["category"],
//     brand: json["brand"],
//     country: json["country"],

//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "subtitle": subtitle,
//     "description": description,
//     "category": category,
//     "brand": brand,
//     "country": country,
//   };
// }

// class ProductCatelogue {
//   int id;
//   int productId;
//   String catalogue;
//   String title;
//   String pdfType;
//   int priority;

//   ProductCatelogue({
//     required this.id,
//     required this.productId,
//     required this.catalogue,
//     required this.title,
//     required this.pdfType,
//     required this.priority,
//   });

//   factory ProductCatelogue.fromJson(Map<String, dynamic> json) => ProductCatelogue(
//     id: json["id"],
//     productId: json["product_id"],
//     catalogue: json["catalogue"],
//     title: json["title"],
//     pdfType: json["pdf_type"],
//     priority: json["priority"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "catalogue": catalogue,
//     "title": title,
//     "pdf_type": pdfType,
//     "priority": priority,
//   };
// }

// class ProductVideo {
//   int id;
//   int productId;
//   String videoUrl;
//   String title;
//   int priority;

//   ProductVideo({
//     required this.id,
//     required this.productId,
//     required this.videoUrl,
//     required this.title,
//     required this.priority,
//   });

//   factory ProductVideo.fromJson(Map<String, dynamic> json) => ProductVideo(
//     id: json["id"],
//     productId: json["product_id"],
//     videoUrl: json["video_url"],
//     title: json["title"],
//     priority: json["priority"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "video_url": videoUrl,
//     "title": title,
//     "priority": priority,
//   };
// }
class ProductDetail {
  Product? product;
  List<AppImage>? productImages;
  List<AppImage>? productBanners;
  List<ProductVideo>? productVideos;
  List<AppImage>? appImages;
  List<ProductCatelogue>? productCatelogues;

  ProductDetail({
    this.product,
    this.productImages,
    this.productBanners,
    this.productVideos,
    this.appImages,
    this.productCatelogues,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        product: json["product"] != null ? Product.fromJson(json["product"]) : null,
        productImages: (json["productImages"] as List<dynamic>?)?.map((x) => AppImage.fromJson(x)).toList(),
        productBanners: (json["productBanners"] as List<dynamic>?)?.map((x) => AppImage.fromJson(x)).toList(),
        productVideos: (json["productVideos"] as List<dynamic>?)?.map((x) => ProductVideo.fromJson(x)).toList(),
        appImages: (json["appImages"] as List<dynamic>?)?.map((x) => AppImage.fromJson(x)).toList(),
        productCatelogues:
            (json["productCatelogues"] as List<dynamic>?)?.map((x) => ProductCatelogue.fromJson(x)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "productImages": productImages?.map((x) => x.toJson()).toList(),
        "productBanners": productBanners?.map((x) => x.toJson()).toList(),
        "productVideos": productVideos?.map((x) => x.toJson()).toList(),
        "appImages": appImages?.map((x) => x.toJson()).toList(),
        "productCatelogues": productCatelogues?.map((x) => x.toJson()).toList(),
      };
}

class AppImage {
  int? id;
  int? productId;
  String? imageUrl;
  String? imageType;
  String? title;
  int? priority;

  AppImage({
    this.id,
    this.productId,
    this.imageUrl,
    this.imageType,
    this.title,
    this.priority,
  });

  factory AppImage.fromJson(Map<String, dynamic> json) => AppImage(
        id: json["id"],
        productId: json["product_id"],
        imageUrl: json["image_url"],
        imageType: json["image_type"],
        title: json["title"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "image_url": imageUrl,
        "image_type": imageType,
        "title": title,
        "priority": priority,
      };
}

class Product {
  int? id;
  String? name;
  String? subtitle;
  String? description;
  String? category;
  String? brand;
  String? country;

  Product({
    this.id,
    this.name,
    this.subtitle,
    this.description,
    this.category,
    this.brand,
    this.country,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        subtitle: json["subtitle"],
        description: json["description"],
        category: json["category"],
        brand: json["brand"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subtitle": subtitle,
        "description": description,
        "category": category,
        "brand": brand,
        "country": country,
      };
}

class ProductCatelogue {
  int? id;
  int? productId;
  String? catalogue;
  String? title;
  String? pdfType;
  int? priority;

  ProductCatelogue({
    this.id,
    this.productId,
    this.catalogue,
    this.title,
    this.pdfType,
    this.priority,
  });

  factory ProductCatelogue.fromJson(Map<String, dynamic> json) => ProductCatelogue(
        id: json["id"],
        productId: json["product_id"],
        catalogue: json["catalogue"],
        title: json["title"],
        pdfType: json["pdf_type"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "catalogue": catalogue,
        "title": title,
        "pdf_type": pdfType,
        "priority": priority,
      };
}

class ProductVideo {
  int? id;
  int? productId;
  String? videoUrl;
  String? title;
  int? priority;

  ProductVideo({
    this.id,
    this.productId,
    this.videoUrl,
    this.title,
    this.priority,
  });

  factory ProductVideo.fromJson(Map<String, dynamic> json) => ProductVideo(
        id: json["id"],
        productId: json["product_id"],
        videoUrl: json["video_url"],
        title: json["title"],
        priority: json["priority"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "video_url": videoUrl,
        "title": title,
        "priority": priority,
      };
}

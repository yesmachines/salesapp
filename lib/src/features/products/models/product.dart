// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int? id;
  String? name;
  String? subtitle;
  String? slug;
  int? categoryId;
  int? brandId;
  String? description;
  int? managerId;
  String? defaultImage;
  int? isDemo;
  int? isFeatured;
  int? topRated;
  dynamic menuOrder;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? category;
  String? brand;
  String? imageUrl;
  String? manager;

  Product({
    this.id,
    this.name,
    this.subtitle,
    this.slug,
    this.categoryId,
    this.brandId,
    this.description,
    this.managerId,
    this.defaultImage,
    this.isDemo,
    this.isFeatured,
    this.topRated,
    this.menuOrder,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.brand,
    this.imageUrl,
    this.manager,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        subtitle: json["subtitle"],
        slug: json["slug"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        description: json["description"],
        managerId: json["manager_id"],
        defaultImage: json["default_image"],
        isDemo: json["is_demo"],
        isFeatured: json["is_featured"],
        topRated: json["top_rated"],
        menuOrder: json["menu_order"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        category: json["category"],
        brand: json["brand"],
        imageUrl: json["image_url"],
        manager: json["manager"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "subtitle": subtitle,
        "slug": slug,
        "category_id": categoryId,
        "brand_id": brandId,
        "description": description,
        "manager_id": managerId,
        "default_image": defaultImage,
        "is_demo": isDemo,
        "is_featured": isFeatured,
        "top_rated": topRated,
        "menu_order": menuOrder,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category,
        "brand": brand,
        "image_url": imageUrl,
        "manager": manager,
      };
}

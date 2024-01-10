class BrandSuppliersResModel {
  num id;
  String? brand;
  String? shortCode;
  String? logoUrl;
  String? website;
  String? description;
  num? countryId;
  String? division;
  num? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  BrandSuppliersResModel({
    required this.id,
    this.brand,
    this.shortCode,
    this.logoUrl,
    this.website,
    this.description,
    this.countryId,
    this.division,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandSuppliersResModel.fromJson(Map<String, dynamic> json) => BrandSuppliersResModel(
        id: json["id"],
        brand: json["brand"],
        shortCode: json["short_code"],
        logoUrl: json["logo_url"],
        website: json["website"],
        description: json["description"],
        countryId: json["country_id"],
        division: json["division"],
        status: json["status"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );
}

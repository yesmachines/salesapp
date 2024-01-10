import 'dart:convert';

List<Divisions> divisionsFromJson(String str) => List<Divisions>.from(json.decode(str).map((x) => Divisions.fromJson(x)));

String divisionsToJson(List<Divisions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Divisions {
  String name;
  String id;
  String image;

  Divisions({
    required this.name,
    required this.id,
    required this.image,
  });

  factory Divisions.fromJson(Map<String, dynamic> json) => Divisions(
    name: json["name"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "image": image,
  };
}

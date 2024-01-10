// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  int id;
  int userId;
  String phone;
  String designation;
  int department;
  String imageUrl;
  String linkedin;
  String username;
  String useremail;
  // int managerId;
  // int priority;
  // int status;
  // DateTime createdAt;
  // DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.userId,
    required this.phone,
    required this.designation,
    required this.department,
    required this.imageUrl,
    required this.linkedin,
    required this.username,
    required this.useremail,
    // required this.managerId,
    // required this.priority,
    // required this.status,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    userId: json["user_id"],
    phone: json["phone"],
    designation: json["designation"],
    department: json["department"],
    imageUrl: json["image_url"],
    linkedin: json["linkedin"],
    username: json["username"],
    useremail: json["useremail"],
    // managerId: json["manager_id"],
    // priority: json["priority"],
    // status: json["status"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "phone": phone,
    "designation": designation,
    "department": department,
    "image_url": imageUrl,
    "linkedin": linkedin,
    "username": username,
    "useremail": useremail,
    // "manager_id": managerId,
    // "priority": priority,
    // "status": status,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}

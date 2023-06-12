import 'package:flutter/material.dart';

class CategoryModel extends ChangeNotifier {
  int? id;
  String? name;
  String? image;
  String? creationAt;
  String? updatedAt;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }

  static List<CategoryModel> categoryFromSnapShot(List categorySnapShot) {
    return categorySnapShot.map((data) {
      return CategoryModel.fromJson(data);
    }).toList();
  }
}

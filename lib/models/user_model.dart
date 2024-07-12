import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? displayPicture;


  UserModel(
      this.name,
      this.email,
      this.displayPicture,
      );

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   email = json['email'];
  //   displayPicture = json['display_picture'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['name'] = name ?? "";
  //   data['email'] = email ?? "";
  //   data['display_picture'] = displayPicture ?? "";
  //   return data;
  // }
}
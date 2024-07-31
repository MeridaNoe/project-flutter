import 'dart:convert';
import './Genre.dart';
List<PersonModel> peopleModelFromJson(String str) => List<PersonModel>.from(json.decode(str).map((x) => PersonModel.fromJson(x)));
String peopleModelToJson(List<PersonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonModel{

  final int id;
  final String name;
  final GenderModel gender;
  final String email;
  final String phone;

  PersonModel({required this.id, required this.name, required this.gender, required this.email, required this.phone });


  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        id: json['id'],
        name: json['name'],
        gender: GenderModel.fromJson(json['gender']),
        email: json['email'],
        phone: json['phone']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'email': email,
      'phone': phone
    };
  }
}

import 'dart:convert';

List<GenderModel> genderModelFromJson(String str) => List<GenderModel>.from(json.decode(str).map((x) => GenderModel.fromJson(x)));
String peopleModelToJson(List<GenderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GenderModel {
  GenderModel({
    required this.gender,
  });

  final String gender;


  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "gender": gender,
  };

}
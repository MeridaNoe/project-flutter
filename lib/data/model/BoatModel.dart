import 'dart:convert';
List<BoatModel> botatModelFromJson(String str) => List<BoatModel>.from(json.decode(str).map((x) => BoatModel.fromJson(x)));
String botatModelToJson(List<BoatModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoatModel{

  final int id;
  final String marca;
  final String modelo;
  final String velocidadMaxima;
  final String peso;

  BoatModel({required this.id, required this.marca, required this.modelo, required this.velocidadMaxima, required this.peso });


  factory BoatModel.fromJson(Map<String, dynamic> json) {
    return BoatModel(
        id: json['id'],
        marca: json['marca'],
        modelo: json['modelo'],
        velocidadMaxima: json['velocidadMaxima'],
        peso: json['peso']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'velocidadMaxima': velocidadMaxima,
      'peso': peso
    };
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/BoatModel.dart';

class BoatRepository {
  final String baseUrl = 'https://oj44u5xwf5.execute-api.us-east-1.amazonaws.com/Prod';


  Future<List<BoatModel>> getBoats() async {
    final response = await http.get(Uri.parse('$baseUrl/get_boats'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> boatsJson = data['boats'];
      return boatsJson.map((json) => BoatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load boats: ${response.reasonPhrase}');
    }
  }

  Future<void> createBoat(BoatModel boat) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save_boat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(boat.toJson()),
    );

    if (response.statusCode == 201) {
      throw Exception('Created boat successfully');
    }
  }

  Future<void> updateBoat(BoatModel boat) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update_boat/${boat.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(boat.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update boat');
    }
  }

  Future<void> deleteBoat(BoatModel boat) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete_boat/${boat.id}'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete boat');
    }
  }
}
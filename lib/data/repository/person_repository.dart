import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model//PersonModel.dart';

class PersonRepository {
  final String apiURL;
  final String accessToken;

  PersonRepository({required this.apiURL, required this.accessToken});

  Future<void> createPerson(PersonModel person) async {
    final response = await http.post(
      Uri.parse('$apiURL/person'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(person.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create person');
    }
  }

  Future<PersonModel> getPerson(int id) async {
    final response = await http.get(
      Uri.parse('$apiURL/person/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return PersonModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load person');
    }
  }

  Future<void> updatePerson(PersonModel person) async {
    final response = await http.put(
      Uri.parse('$apiURL/person/${person.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(person.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update person');
    }
  }

  Future<void> deletePerson(int id) async {
    final response = await http.delete(
      Uri.parse('$apiURL/person/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete person');
    }
  }

  Future<List<PersonModel>> getAll() async {
    final response = await http.get(
      Uri.parse('$apiURL/person'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return List<PersonModel>.from(
          jsonDecode(response.body).map((x) => PersonModel.fromJson(x)));
    } else {
      throw Exception('Failed to load people');
    }
  }
}
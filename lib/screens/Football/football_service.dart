import 'dart:convert';
import 'package:http/http.dart' as http;
import 'FootballModel.dart';

class FootballService {
  final String baseUrl = 'https://www.thesportsdb.com/api/v1/json/3';

  Future<List<FootballModel>> fetchTeams() async {
    final response = await http.get(Uri.parse('$baseUrl/search_all_teams.php?s=Soccer&c=England'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List footballList = data['teams'];
      return footballList.map((json) => FootballModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }
}
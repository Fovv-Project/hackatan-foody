import 'dart:convert';
import 'package:hackatan_ui/data/model/restaurant.dart';
import 'package:http/http.dart' as http;

// const String BASE_URL = '';

class ApiService {
  static const String _baseUrl = 'http://172.16.63.74:8080';

  Future<List<Restaurant>> getRestaurant() async {
    final response = await http.get(Uri.parse('$_baseUrl/get'));
    if (response.statusCode == 201) {
      return Restaurant.fromJsonArray(json.decode(response.body));
    } else {
      throw Exception('failed to load list of restaurant');
    }
  }

  Future<List<Restaurant>> getSearch(params) async {
    final api = params == "" ? http.get(Uri.parse('$_baseUrl/get')) : http.get(Uri.parse('$_baseUrl/search_with_ai?text=$params'));
    final response =
        await api;
    if (response.statusCode == 201) {
      return Restaurant.fromJsonArray(json.decode(response.body));
    } else {
      throw Exception('failed to search');
    }
  }
}

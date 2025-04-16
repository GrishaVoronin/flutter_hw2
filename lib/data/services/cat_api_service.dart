import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../data/models/cat_model.dart';
import '../../data/models/breed_model.dart';

class CatApiService {
  static const String _baseUrl =
      'https://api.thecatapi.com/v1/images/search?has_breeds=1';
  static const String _apiKey =
      'live_p9cy297ylKoWrFM5rm3HkAXFXP1S1jgp2FduEAzLA6TsaqgG67fEA8jNkVHAEIcc';

  Future<CatModel?> getRandomCat() async {
    final url = Uri.parse(_baseUrl);
    final response = await http.get(
      url,
      headers: {'x-api-key': _apiKey},
    );

    if (kDebugMode) {
      debugPrint('Status code: ${response.statusCode}');
    }

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      if (data.isNotEmpty) {
        return CatModel.fromJson(data.first as Map<String, dynamic>);
      }
    } else {
      if (kDebugMode) {
        debugPrint('Failed to load cat: ${response.statusCode}');
      }
    }

    return null;
  }

  Future<List<CatModel>> getMultipleCats(int count) async {
    List<CatModel> cats = [];

    for (int i = 0; i < count; i++) {
      final cat = await getRandomCat();
      if (cat != null) {
        cats.add(cat);
      }
    }

    return cats;
  }

  Future<List<BreedModel>> getBreeds() async {
    final url = Uri.parse('https://api.thecatapi.com/v1/breeds');
    final response = await http.get(
      url,
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => BreedModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load breeds: ${response.statusCode}');
    }
  }
}

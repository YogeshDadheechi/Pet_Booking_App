import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet_service.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PetService>> fetchServices() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts?_limit=4'),
      headers: {
        "Accept": "application/json",
        "User-Agent": "Mozilla/5.0",
      },
    );

    print("STATUS CODE: ${response.statusCode}");

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final serviceNames = [
        'Pet Grooming',
        'Pet Walking',
        'Pet Cleaning',
        'Pet Boarding'
      ];

      final serviceDescs = [
        'Professional grooming to keep your pet fresh & stylish',
        'Daily walks with trained & caring walkers',
        'Deep cleaning for a happy, healthy pet',
        'Safe & comfortable boarding when you\'re away',
      ];

      // 🔥 SAFE LOOP (NO RANGE ERROR EVER)
      List<PetService> services = [];

      for (int i = 0; i < data.length && i < serviceNames.length; i++) {
        final jsonMap = Map<String, dynamic>.from(data[i]);

        jsonMap['title'] = serviceNames[i];
        jsonMap['body'] = serviceDescs[i];
        jsonMap['id'] = i + 1;

        services.add(PetService.fromJson(jsonMap));
      }

      return services;
    } else {
      throw Exception('Failed to load services. Status: ${response.statusCode}');
    }
  }
}
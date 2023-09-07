import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRepository {
  Future fetchData() async {
    final response = await http
        .get(Uri.parse('http://coding-assignment.bombayrunning.com/data.json'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

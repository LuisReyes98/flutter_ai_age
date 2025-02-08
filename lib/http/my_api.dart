import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

final String mainApiUrl = 'http://your.api.endpoint/';

Uri getUrlForEndpoint(String endpoint) {
  return Uri.parse('$mainApiUrl$endpoint');
}

Future<Map<String, dynamic>> sendJsonData(
    Map<String, dynamic> jsonData, Uri apiUrl) async {
  try {
    final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint('Data sent successfully: ${response.body}');
      return {
        'status': response.statusCode,
        'data': jsonDecode(response.body),
      };
    } else {
      debugPrint('Failed to send data. Status code: ${response.statusCode}');
      return {
        'status': response.statusCode,
      };
    }
  } catch (e) {
    debugPrint('Error sending data: $e');
    return {
      'status': 500,
    };
  }
}

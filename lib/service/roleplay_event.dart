import 'dart:convert';

import 'package:larpland/model/roleplay_event.dart';
import 'package:http/http.dart' as http;

Future<List<RoleplayEvent>> fetchEventList() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/events'));
  if (response.statusCode == 200) {
    return List<RoleplayEvent>.from(jsonDecode(response.body).map((event) => RoleplayEvent.fromJson(event)));
  } else {
    throw Exception('Failed to fetch event list');
  }
}
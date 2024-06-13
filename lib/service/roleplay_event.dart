import 'dart:convert';


import 'package:larpland/model/roleplay_event.dart';
import 'package:http/http.dart' as http;

Future<List<RoleplayEvent>> fetchEventList() async {
  final response = await http.get(Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/events'));
  if (response.statusCode == 200) {
    return List<RoleplayEvent>.from(jsonDecode(response.body)
        .map((event) => RoleplayEvent.fromJson(event)));
  } else {
    throw Exception('Failed to fetch event list');
  }
}

Future<RoleplayEvent> addEvent(String name, String description,
    String fechaInicio, String fechaFin) async {
  final response = await http.post(
    Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/events'),
    body: {
      'nombre': name,
      'descripcion': description,
      'fecha_inicio': fechaInicio,
      'fecha_fin': fechaFin,
    },
  );
  if (response.statusCode == 200) {
    return RoleplayEvent.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falló al agregar evento');
  }
}

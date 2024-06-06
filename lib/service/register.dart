import 'dart:convert';

import 'package:larpland/model/user.dart';
import 'package:http/http.dart' as http;

Future<User> register(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse("http://10.0.2.2:8000/api/users"),
    body: {
      'name': name,
      'email': email,
      'password': password,
    },
  );
  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Registro fallido');
    
  }
}
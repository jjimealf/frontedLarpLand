import 'package:larpland/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<User>> fetchUserList() async {
  final response = await http.get(Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/users'));
  if (response.statusCode == 200) {
    return List<User>.from(
        jsonDecode(response.body).map((user) => User.fromJson(user)));
  } else {
    throw Exception('Falló al cargar la lista de usuarios');
  }
}

Future<User> showUser(int id) async {
  final response = await http.get(Uri.parse('https://mongoose-hip-lark.ngrok-free.app/api/users/$id'));
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falló al cargar el usuario');
  }
}

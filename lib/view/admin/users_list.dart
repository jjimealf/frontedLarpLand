import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:larpland/model/user.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late Future<List<User>> futureUserList;

  @override
  void initState() {
    super.initState();
    futureUserList = fetchUserList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: futureUserList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].email),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<List<User>> fetchUserList() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/users'));
    if (response.statusCode == 200) {
      return List<User>.from(jsonDecode(response.body).map((user) => User.fromJson(user)));
    } else {
      throw Exception('Failed to fetch user list');
    }
  }
}

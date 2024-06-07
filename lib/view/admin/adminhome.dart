import 'package:flutter/material.dart';
import 'package:larpland/view/admin/product_list.dart';
import 'package:larpland/view/admin/users_list.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screen = [const UsersList(), const ProductList()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => setState(() => selectedIndex = value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}

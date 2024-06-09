import 'package:flutter/material.dart';
import 'package:larpland/view/admin/event_list.dart';
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
    final screen = [const UsersList(), const ProductList(), const EventScreen()];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Home'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => Navigator.pop(context),
        )
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
            icon: Icon(Icons.verified_user),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
        ],
      ),
    );
  }
}

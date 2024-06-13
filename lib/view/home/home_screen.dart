import 'package:flutter/material.dart';
import 'package:larpland/view/home/catalog.dart';
import 'package:larpland/view/home/event_list.dart';

class HomeScreen extends StatefulWidget {

  final int userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screen = [
      CatalogScreen(userId: widget.userId),
      const EventPage()
    ];

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          )),
      body: IndexedStack(
        index: selectedIndex,
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => setState(() => selectedIndex = value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
          ),
        ],
      ),
    );
  }
}

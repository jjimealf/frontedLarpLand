import 'package:flutter/material.dart';
import 'package:larpland/model/roleplay_event.dart';
import 'package:larpland/service/roleplay_event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {

  late Future<List<RoleplayEvent>> eventList;

  @override
  void initState() {
    super.initState();
    eventList = fetchEventList();
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RoleplayEvent>>(
      future: eventList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].fechaInicio.toString()),
                trailing: Text(snapshot.data![index].fechaFin.toString()),
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
}

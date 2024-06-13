import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:larpland/model/roleplay_event.dart';
import 'package:larpland/service/roleplay_event.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late Future<List<RoleplayEvent>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEventList();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    initializeNotifications();
    scheduleEventNotifications();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Manejar notificación en primer plano
  }

  Future onSelectNotification(String? payload) async {
    // Manejar acción de selección de notificación
  }

  void scheduleEventNotifications() async {
    final now = DateTime.now();
    final events = await futureEvents;
    for (var event in events) {
      final eventDate = DateTime.parse(event.fechaInicio);
      if (eventDate.isAfter(now) && eventDate.difference(now).inHours <= 24) {
        scheduleNotification(event);
      }
    }
  }

  void scheduleNotification(RoleplayEvent event) async {
    await flutterLocalNotificationsPlugin.show(
      event.id,
      event.name,
      event.fechaInicio,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Eventos"),
      ),
      body: FutureBuilder<List<RoleplayEvent>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      title: Text(event.name),
                      subtitle: Text(
                          "${event.description}\nFecha: ${event.fechaInicio} - ${event.fechaFin}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (event.isRegistered) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Ya estás inscrito en este evento")));
                            } else {
                              event.isRegistered = true;
                            }
                          });
                        },
                        child: Text(
                            event.isRegistered ? "Inscrito" : "Inscribirse"),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}

class InheritedNotificationService extends InheritedWidget {
  final NotificationService notificationService;

  const InheritedNotificationService({
    Key? key,
    required this.notificationService,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedNotificationService oldWidget) {
    return notificationService != oldWidget.notificationService;
  }

  static NotificationService of(BuildContext context) {
    final InheritedNotificationService? result = context
        .dependOnInheritedWidgetOfExactType<InheritedNotificationService>();
    assert(result != null, 'No NotificationService found in context');
    return result!.notificationService;
  }
}

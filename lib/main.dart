import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/screens/tabs_screen.dart';
import 'package:todoapp/services/app_router.dart';

import 'bloc/bloc_exports.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
      notificationService: NotificationService(flutterLocalNotificationsPlugin),
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.appRouter, required this.notificationService});
  final AppRouter appRouter;
  final NotificationService notificationService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        home: TabScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
        builder: (context, child) {
          return InheritedNotificationService(
            notificationService: notificationService,
            child: child!,
          );
        },
      ),
    );
  }
}

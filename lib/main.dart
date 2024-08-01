import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/screens/task_screen.dart';
import 'package:todoapp/services/app_router.dart';

import 'bloc/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: AppRouter(),
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        home: TaskScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}

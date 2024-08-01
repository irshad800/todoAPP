import 'package:flutter/material.dart';
import 'package:todoapp/screens/pending_screen.dart';
import 'package:todoapp/screens/recycle_bin.dart';

import '../screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(
          builder: (_) => const RecycleBin(),
        );
      case PendingScreen.id:
        return MaterialPageRoute(
          builder: (_) => TabScreen(),
        );
      default:
        return null;
    }
  }
}

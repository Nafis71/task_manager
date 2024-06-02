import 'package:flutter/material.dart';
import 'package:task_manager/views/splashScreen/splash_screen.dart';

class Routes {
  static const splashScreen = "/splashScreen";

  static MaterialPageRoute? generateRoute(RouteSettings routeSettings) {
    final Map<String, WidgetBuilder> routes = {
      splashScreen: (context) => const SplashScreen(),
    };
    final WidgetBuilder? builder = routes[routeSettings.name];
    return (builder != null) ? MaterialPageRoute(builder: builder) : null;
  }
}

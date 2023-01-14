import 'package:api_tempest/utils/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:seafarer/seafarer.dart';

class Routes {
  static final seafarer = Seafarer(
    options: const SeafarerOptions(
      isLoggingEnabled: true,
    ),
  );

  static void createRoutes() {
    seafarer.addRoutes(
      [
        SeafarerRoute(
          name: RoutePaths.configuration,
          builder: (context, args, params) => Container(),
        ),
      ],
    );
  }

  static void replaceScreen(String nextScreen, {args}) {
    Routes.seafarer.navigate(nextScreen,
        navigationType: NavigationType.pushAndRemoveUntil,
        removeUntilPredicate: (Route<dynamic> current) => false,
        args: args);
  }
}

import 'package:api_tempest/utils/logger/logger.dart';
import 'package:flutter/material.dart';

class RouteChangeObserver extends NavigatorObserver {
  final logger = getLogger('RouteChangeObserver');

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    logger.i("[seafarer] Route Pushed: "
        "(Pushed Route='${route.settings.name}', "
        "Previous Route='${previousRoute?.settings.name}', "
        "New Route Args=${route.settings.arguments}, "
        "Previous Route Args=${previousRoute?.settings.arguments}"
        ")");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    logger.i("[seafarer] Route Popped: "
        "(New Route='${previousRoute?.settings.name}', "
        "Popped Route='${route.settings.name}', "
        "New Route Args=${previousRoute?.settings.arguments}, "
        "Previous Route Args=${route.settings.arguments}"
        ")");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    logger.i("[seafarer] Route Replaced: "
        "(New Route='${newRoute?.settings.name}', "
        "Old Route='${oldRoute?.settings.name}', "
        "Arguments=${newRoute?.settings.arguments}"
        ")");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);

    logger.i("[seafarer] Route Removed: "
        "(New Route='${previousRoute?.settings.name}', "
        "Removed Route='${route.settings.name}', "
        "New Route Args=${previousRoute?.settings.arguments}, "
        "Removed Route Args=${route.settings.arguments}"
        ")");
  }
}

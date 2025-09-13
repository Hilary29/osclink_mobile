import 'package:flutter/material.dart';

class RouteLoggerObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _logNavigation('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _logNavigation('POP', route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _logNavigation('REPLACE', newRoute, oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _logNavigation('REMOVE', route, previousRoute);
  }

  void _logNavigation(String action, Route<dynamic>? route, Route<dynamic>? previousRoute) {
    final routeName = route?.settings.name ?? 'Unknown';
    final previousRouteName = previousRoute?.settings.name ?? 'None';
    final arguments = route?.settings.arguments;
    
    debugPrint('🚀 NAVIGATION $action: $routeName');
    debugPrint('   Previous: $previousRouteName');
    if (arguments != null) {
      debugPrint('   Arguments: $arguments');
    }
    debugPrint('   ─────────────────────────');
  }
}
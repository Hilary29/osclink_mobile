import 'package:flutter/material.dart';
import 'package:osclink_mobile/3_auth/presentation/screens/login_screen.dart';
import 'package:osclink_mobile/3_auth/presentation/screens/signup_screen.dart';
import 'package:osclink_mobile/4_profile/data/models/profile_model.dart';
import 'package:osclink_mobile/4_profile/presentation/screens/profile_screen.dart';
import 'package:osclink_mobile/7_chat/presentation/screens/chat_screen.dart';
import 'package:osclink_mobile/8_projects/presentation/screens/projects_screen.dart';
import 'package:osclink_mobile/9_resources/presentation/screens/resources_screen.dart';
import 'route_path.dart';
import '../screens/splash_screen.dart';
import '../screens/not_found_screen.dart';
import '../widgets/bottom_navigation_wrapper.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    
    switch (settings.name) {
      case RoutePath.splash:
        return _buildRoute(const SplashScreen(), settings);
        
      case RoutePath.login:
        return _buildRoute(const LoginScreen(), settings);
        
      case RoutePath.signup:
        return _buildRoute(const SignupScreen(), settings);
        
      case RoutePath.home:
        return _buildRoute(const BottomNavigationWrapper(initialIndex: 0), settings);
        
      case RoutePath.chat:
        return _buildRoute(const BottomNavigationWrapper(initialIndex: 1), settings);
        
      case RoutePath.map:
        return _buildRoute(const BottomNavigationWrapper(initialIndex: 2), settings);
        
      case RoutePath.profile:
        return _buildRoute(const BottomNavigationWrapper(initialIndex: 3), settings);
        
      case RoutePath.projects:
        return _buildRoute(const ProjectsScreen(), settings);
        
      case RoutePath.resources:
        return _buildRoute(const ResourcesScreen(), settings);
        
      case RoutePath.chatDetail:
        if (args is Map<String, dynamic>) {
          return _buildRoute(ChatDetailScreen(conversationId: args['chatId'] as String), settings);
        }
        return _buildRoute(const NotFoundScreen(), settings);
        
      case RoutePath.projectDetail:
        if (args is Map<String, dynamic>) {
          return _buildRoute(ProjectDetailScreen(projectId: args['projectId']), settings);
        }
        return _buildRoute(const NotFoundScreen(), settings);
        
      case RoutePath.profileEdit:
        if (args is UserProfile) {
          return _buildRoute(ProfileEditScreen(profile: args), settings);
        }
        return _buildRoute(const NotFoundScreen(), settings);
        
      case RoutePath.profileSettings:
        return _buildRoute(const ProfileSettingsScreen(), settings);
        
      default:
        return _buildRoute(const NotFoundScreen(), settings);
    }
  }
  
  static PageRoute<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class NavigationHelper {
  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
      context,
      routeName,
      arguments: arguments,
    );
  }
  
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );
  }
  
  static Future<T?> pushNamedAndClearStack<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
  
  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop<T>(context, result);
  }
  
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
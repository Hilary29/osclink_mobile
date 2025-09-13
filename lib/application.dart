import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '1_common/presentation/router/router.dart';
import '1_common/presentation/router/route_path.dart';
import '1_common/presentation/router/route_logger_observer.dart';
import '1_common/business_logic/common_bloc.dart';
import '2_home/business_logic/home_bloc.dart';
import '3_auth/business_logic/auth_bloc.dart';
import '4_profile/business_logic/profile_bloc.dart';
import '5_feed/business_logic/feed_bloc.dart';
import '7_chat/business_logic/chat_bloc.dart';
import '9_resources/business_logic/resources_bloc.dart';

class OSCLinkApp extends StatelessWidget {
  const OSCLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommonBloc>(
          create: (context) => CommonBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => FeedBloc(),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(),
        ),
        BlocProvider<ResourcesBloc>(
          create: (context) => ResourcesBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'OSC Link',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        initialRoute: RoutePath.splash,
        onGenerateRoute: AppRouter.generateRoute,
        navigatorObservers: [
          RouteLoggerObserver(),
        ],
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
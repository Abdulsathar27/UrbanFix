import 'package:flutter/material.dart';
import 'package:frontend/controller/appointment_controller.dart';
import 'package:frontend/controller/chat_controller.dart';
import 'package:frontend/controller/job_controller.dart';
import 'package:frontend/controller/message_controller.dart';
import 'package:frontend/controller/notification_controller.dart';
import 'package:frontend/controller/report_controller.dart';
import 'package:frontend/controller/theme_controller.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentController(),
        ),
        ChangeNotifierProvider(
          create: (_) => JobController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatController(),
        ),
        ChangeNotifierProvider(
          create: (_) => MessageController(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportController(),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'UrbanFix',

            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,

            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}

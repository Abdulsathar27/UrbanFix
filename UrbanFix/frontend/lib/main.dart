import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/controller/chat_controller.dart';
import 'package:frontend/data/controller/job_controller.dart';
import 'package:frontend/data/controller/message_controller.dart';
import 'package:frontend/data/controller/notification_controller.dart';
import 'package:frontend/data/controller/report_controller.dart';
import 'package:frontend/data/controller/theme_controller.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/data/services/appointment_api_service.dart';
import 'package:frontend/data/services/chat_api_service.dart';
import 'package:frontend/data/services/job_api_service.dart';
import 'package:frontend/data/services/message_api_service.dart';
import 'package:frontend/data/services/notification_api_service.dart';
import 'package:frontend/data/services/report_api_service.dart';
import 'package:frontend/data/services/user_api_service.dart';
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
          create: (_) => UserController(context.read<UserApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentController(context.read<AppointmentApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => JobController(context.read<JobApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatController(context.read<ChatApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => MessageController(context.read<MessageApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationController(context.read<NotificationApiService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportController(context.read<ReportApiService>()),
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

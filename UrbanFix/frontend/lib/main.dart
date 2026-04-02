import 'package:flutter/material.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'core/utils/token_store.dart';
import 'data/controller/appointment_controller.dart';
import 'data/controller/chat_controller.dart';
import 'data/controller/job_controller.dart';
import 'data/controller/message_controller.dart';
import 'data/controller/notification_controller.dart';
import 'data/controller/address_controller.dart';
import 'data/controller/location_controller.dart';
import 'data/controller/report_controller.dart';
import 'data/controller/theme_controller.dart';
import 'data/controller/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenStore.loadToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => AppointmentController()),
        ChangeNotifierProvider(
          create: (_) {
            final controller = JobController();
            controller.fetchJobs();
            return controller;
          },
        ),
        ChangeNotifierProvider(create: (_) => ChatController()),
        ChangeNotifierProvider(create: (_) => MessageController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => ReportController()),
        ChangeNotifierProvider(create: (_) => LocationController()),
        ChangeNotifierProvider(create: (_) => AddressController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'UrbanFix',

            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,

            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}

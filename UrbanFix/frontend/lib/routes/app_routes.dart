import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/auth/otp/otp_screen.dart';

import '../presentation/screens/splash/splash_screen.dart';
import '../presentation/screens/auth/login/login_screen.dart';
import '../presentation/screens/auth/register/register_screen.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/user/profile_screen.dart';
import '../presentation/screens/user/edit_profile_screen.dart';
import '../presentation/screens/appointment/appointment_list_screen.dart';
import '../presentation/screens/appointment/appointment_details_screen.dart';
import '../presentation/screens/job/job_list_screen.dart';
import '../presentation/screens/job/job_details_screen.dart';
import '../presentation/screens/chat/chat_list_screen.dart';
import '../presentation/screens/chat/chat_screen.dart';
import '../presentation/screens/notification/notification_screen.dart';
import '../presentation/screens/report/report_screen.dart';

class AppRoutes {
  // ================= Splash =================
  static const String splash = '/';

  // ================= Auth =================
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';

  // ================= Home =================
  static const String home = '/home';

  // ================= User =================
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  // ================= Appointment =================
  static const String appointments = '/appointments';
  static const String appointmentDetails =
      '/appointment-details';

  // ================= Job =================
  static const String jobs = '/jobs';
  static const String jobDetails = '/job-details';
  static const String createJob = '/create-job';

  // ================= Chat =================
  static const String chats = '/chats';
  static const String chatDetails = '/chat-details';

  // ================= Notification =================
  static const String notifications =
      '/notifications';

  // ================= Report =================
  static const String report = '/report';

  // ================= Route Generator =================
  static Route<dynamic> generateRoute(
      RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _materialRoute(
            const SplashScreen());

      case login:
        return _materialRoute(
            const LoginScreen());

      case register:
        return _materialRoute(
            const RegisterScreen());
      case otp:
        return _materialRoute(
            const OtpScreen());

      case home:
        return _materialRoute(
            const HomeScreen());

      case profile:
        return _materialRoute(
            const ProfileScreen());

      case editProfile:
        return _materialRoute(
            const EditProfileScreen());

      case appointments:
        return _materialRoute(
            const AppointmentListScreen());

      case appointmentDetails:
        return _materialRoute(
            const AppointmentDetailsScreen());

      case jobs:
        return _materialRoute(
            const JobListScreen());

      case jobDetails:
        return _materialRoute(
            const JobDetailsScreen());

      case chats:
        return _materialRoute(
            const ChatListScreen());

      case chatDetails:
        return _materialRoute(
            const ChatScreen());

      case notifications:
        return _materialRoute(
            const NotificationScreen());

      case report:
        return _materialRoute(
            const ReportScreen());

      default:
        return _materialRoute(
          const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _materialRoute(
      Widget page) {
    return MaterialPageRoute(
      builder: (_) => page,
    );
  }
}

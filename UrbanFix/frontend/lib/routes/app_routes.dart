import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Splash
import '../presentation/screens/splash/splash_screen.dart';

// Auth
import '../presentation/screens/auth/login/login_screen.dart';
import '../presentation/screens/auth/register/register_screen.dart';
import '../presentation/screens/auth/otp/otp_screen.dart';

// Home
import '../presentation/screens/home/home_screen.dart';

// User
import '../presentation/screens/user/profile_screen.dart';
import '../presentation/screens/user/edit_profile_screen.dart';

// Appointment
import '../presentation/screens/appointment/appointment_list_screen.dart';
import '../presentation/screens/appointment/appointment_details_screen.dart';

// Job
import '../presentation/screens/job/job_list_screen.dart';
import '../presentation/screens/job/job_details_screen.dart';

// Chat
import '../presentation/screens/chat/chat_list_screen.dart';
import '../presentation/screens/chat/chat_screen.dart';

// Notification
import '../presentation/screens/notification/notification_screen.dart';

// Report
import '../presentation/screens/report/report_screen.dart';

class AppRouter {
  /// 🔥 Global Navigator Key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// 🔥 GoRouter Instance
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      /// ================= Splash =================
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      /// ================= Auth =================
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/otp',
        name: 'otp',
        builder: (context, state) => const OtpScreen(),
      ),

      /// ================= Home =================
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      /// ================= User =================
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: '/edit-profile',
        name: 'editProfile',
        builder: (context, state) => const EditProfileScreen(),
      ),

      /// ================= Appointment =================
      GoRoute(
        path: '/appointments',
        name: 'appointments',
        builder: (context, state) =>
            const AppointmentListScreen(),
      ),

      GoRoute(
        path: '/appointment-details',
        name: 'appointmentDetails',
        builder: (context, state) =>
            const AppointmentDetailsScreen(),
      ),

      /// ================= Job =================
      GoRoute(
        path: '/jobs',
        name: 'jobs',
        builder: (context, state) => const JobListScreen(),
      ),

      GoRoute(
        path: '/job-details',
        name: 'jobDetails',
        builder: (context, state) =>
            const JobDetailsScreen(),
      ),

      /// ================= Chat =================
      GoRoute(
        path: '/chats',
        name: 'chats',
        builder: (context, state) =>
            const ChatListScreen(),
      ),

      GoRoute(
        path: '/chat-details',
        name: 'chatDetails',
        builder: (context, state) =>
            const ChatScreen(),
      ),

      /// ================= Notification =================
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) =>
            const NotificationScreen(),
      ),

      /// ================= Report =================
      GoRoute(
        path: '/report',
        name: 'report',
        builder: (context, state) =>
            const ReportScreen(),
      ),
    ],
  );
}
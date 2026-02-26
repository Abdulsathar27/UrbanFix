import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/home/home_screen.dart';
import 'package:frontend/presentation/screens/home/widget/main_navigation_screen.dart';
import 'package:go_router/go_router.dart';

// Splash
import '../presentation/screens/splash/splash_screen.dart';

// Auth
import '../presentation/screens/auth/login/login_screen.dart';
import '../presentation/screens/auth/register/register_screen.dart';
import '../presentation/screens/auth/otp/otp_screen.dart';

// User
import '../presentation/screens/user/profile_screen.dart';
import '../presentation/screens/user/widgets/edit_profile_screen.dart';

// Appointment / Booking
import '../presentation/screens/appointment/booking_screen.dart';
import '../presentation/screens/appointment/success_screen.dart';

// Job
import '../presentation/screens/job/job_list_screen.dart';
import '../presentation/screens/job/job_details_screen.dart';

// Chat
import '../presentation/screens/chat/chat_list_screen.dart';
import '../presentation/screens/chat/chat_screen.dart';

// Notification
import '../presentation/screens/notification/notification_screen.dart';

// Report
import '../presentation/screens/report/report_issue_screen.dart';

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

      /// ================= Main Navigation with ShellRoute =================
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) {
          return MainNavigationScreen(
            key: state.pageKey,
            child: child,
          );
        },
        routes: [
          /// Home Tab
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: HomeScreen(),
              );
            },
            routes: [
              /// Nested routes under home if needed
            ],
          ),

          /// Bookings Tab
          GoRoute(
            path: '/bookings',
            name: 'bookings',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: BookingScreen(),
              );
            },
          ),

          /// Chats Tab
          GoRoute(
            path: '/chats',
            name: 'chats',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ChatListScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'details/:chatId',
                name: 'chatDetails',
                builder: (context, state) {
                  final chatId = state.pathParameters['chatId']!;
                  return ChatScreen(chatId: chatId);
                },
              ),
            ],
          ),

          /// Profile Tab
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: ProfileScreen(),
              );
            },
          ),
        ],
      ),

      /// ================= Other routes (full screen) =================
      GoRoute(
        path: '/edit-profile',
        name: 'editProfile',
        builder: (context, state) => const EditProfileScreen(),
      ),

      GoRoute(
        name: "appointment_success",
        path: "/success",
        builder: (context, state) => const SuccessScreen(),
      ),

      GoRoute(
        path: '/jobs',
        name: 'jobs',
        builder: (context, state) => const JobListScreen(),
      ),

      GoRoute(
        path: '/job-details/:id',
        name: 'jobDetails',
        builder: (context, state) {
          final jobId = state.pathParameters['id']!;
          return JobDetailsScreen(jobId: jobId);
        },
      ),

      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationScreen(),
      ),

      GoRoute(
        path: '/report',
        name: 'report',
        builder: (context, state) => const ReportIssueScreen(),
      ),
    ],
  );
}
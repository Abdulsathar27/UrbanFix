import 'package:flutter/material.dart';
import 'package:frontend/data/controller/appointment_controller.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/presentation/screens/appointment/my_appointments_screen.dart';
import 'package:frontend/presentation/screens/auth/login/login_screen.dart';
import 'package:frontend/presentation/screens/auth/otp/otp_screen.dart';
import 'package:frontend/presentation/screens/auth/register/register_screen.dart';
import 'package:frontend/presentation/screens/booking/booking_screen.dart';
import 'package:frontend/presentation/screens/success/success_screen.dart';
import 'package:frontend/presentation/screens/booking/widgets/select_job.dart';
import 'package:frontend/presentation/screens/booking/widgets/category_selection_screen.dart'; // ✅ ADD THIS
import 'package:frontend/presentation/screens/chat/chat_list_screen.dart';
import 'package:frontend/presentation/screens/chat/chat_screen.dart';
import 'package:frontend/presentation/screens/home/home_screen.dart';
import 'package:frontend/presentation/screens/home/widget/main_navigation_screen.dart';
import 'package:frontend/presentation/screens/home/widget/service_details_page.dart';
import 'package:frontend/presentation/screens/notification/notification_screen.dart';
import 'package:frontend/presentation/screens/notification/notification_detail_screen.dart';
import 'package:frontend/data/models/notification_model.dart';
import 'package:frontend/presentation/screens/address/saved_addresses_screen.dart';
import 'package:frontend/presentation/screens/setting/settings_screen.dart';
import 'package:frontend/presentation/screens/report/report_issue_screen.dart';
import 'package:frontend/presentation/screens/splash/splash_screen.dart';
import 'package:frontend/presentation/screens/user/profile_screen.dart';
import 'package:frontend/presentation/screens/user/widgets/edit_profile_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      // ================= Splash =================
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // ================= Auth =================
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

      // ================= Main Navigation (with bottom nav bar) =================
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainNavigationScreen(key: state.pageKey, child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/bookings',
            name: 'bookings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: BookingScreen(
                category:
                    (state.extra as Map<String, dynamic>?)?['category']
                        as String?,
              ),
            ),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: NotificationScreen()),
          ),
          GoRoute(
            path: '/chats',
            name: 'chats',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ChatListScreen()),
            routes: [
              // Full-screen chat detail — no bottom nav bar
              GoRoute(
                parentNavigatorKey: navigatorKey,
                path: 'details/:chatId',
                name: 'chatDetails',
                builder: (context, state) {
                  final chatId = state.pathParameters['chatId']!;
                  return ChatScreen(chatId: chatId);
                },
              ),
            ],
          ),
        ],
      ),

      // ================= Full-screen routes (no bottom nav bar) =================

      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'my-appointments',
            name: 'my_appointments',
            builder: (context, state) =>
                MyAppointmentsScreen(controller: AppointmentController()),
          ),
        ],
      ),
      GoRoute(
        path: '/service-details',
        name: 'serviceDetails',
        builder: (context, state) {
          final service = state.extra as Service;
          return ServiceDetailsPage(service: service);
        },
      ),

      // ✅ ADD: Category Selection Screen
      GoRoute(
        path: '/select-category',
        name: 'select-category',
        builder: (context, state) => const CategorySelectionScreen(),
      ),

      // ✅ Already exists: select-job moved here so pushNamed can return a value properly
      GoRoute(
        path: '/select-job',
        name: 'select-job',
        builder: (context, state) {
          final category = state.extra as String;
          return SelectJobScreen(category: category);
        },
      ),

      GoRoute(
        path: '/edit-profile',
        name: 'editProfile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/saved-addresses',
        name: 'savedAddresses',
        builder: (context, state) => const SavedAddressesScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/appointment-success',
        name: 'appointment_success',
        builder: (context, state) => const SuccessScreen(),
      ),
      GoRoute(
        path: '/report',
        name: 'report',
        builder: (context, state) => const ReportIssueScreen(),
      ),
      GoRoute(
        path: '/notification-detail',
        name: 'notificationDetail',
        builder: (context, state) {
          final notification = state.extra as NotificationModel;
          return NotificationDetailScreen(notification: notification);
        },
      ),
    ],
  );
}

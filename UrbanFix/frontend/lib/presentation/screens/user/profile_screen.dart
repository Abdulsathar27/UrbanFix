import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/controller/user_controller.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_card.dart';
import 'widgets/logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        final user = controller.currentUser;

        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text("User not found")),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => context.go('/home'),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text("Profile"),
            actions: [
              IconButton(
                onPressed: () => context.goNamed('editProfile'),
                icon: const Icon(Icons.edit),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ProfileHeader(
                  name: user.name,
                  email: user.email,
                  imageUrl: user.profileImage,
                ),
                const SizedBox(height: 30),

                ProfileMenuCard(
                  icon: Icons.calendar_today,
                  title: "My Appointments",
                  onTap: () => context.goNamed('my_appointments'),
                ),
                const SizedBox(height: 15),

                ProfileMenuCard(
                  icon: Icons.location_on,
                  title: "Saved Addresses",
                  onTap: () => context.goNamed('savedAddresses'),
                ),
                const SizedBox(height: 15),

                ProfileMenuCard(
                  icon: Icons.settings,
                  title: "Settings",
                  onTap: () => context.goNamed('settings'),
                ),
                const SizedBox(height: 40),

                const LogoutButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
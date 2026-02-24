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
    final controller = context.read<UserController>();
    final user = controller.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/editProfile');
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text("User not found"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ProfileHeader(
                        name: user.name,
                        email: user.email,
                        imageUrl: user.profileImage,
                      ),
                      const SizedBox(height: 30),

                      /// Menu Cards
                      ProfileMenuCard(
                        icon: Icons.calendar_today,
                        title: "My Appointments",
                        subtitle: "2 upcoming visits",
                        onTap: () {},
                      ),

                      const SizedBox(height: 15),

                      ProfileMenuCard(
                        icon: Icons.location_on,
                        title: "Saved Addresses",
                        subtitle: "Home, Office, Parents",
                        onTap: () {},
                      ),

                      const SizedBox(height: 15),

                      ProfileMenuCard(
                        icon: Icons.settings,
                        title: "Settings",
                        subtitle: "Notifications, security, preferences",
                        onTap: () {},
                      ),

                      const SizedBox(height: 40),

                      const LogoutButton(),
                    ],
                  ),
                ),
    );
  }
}
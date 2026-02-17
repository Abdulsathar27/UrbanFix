import 'package:flutter/material.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UserController>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
      ),
      body: Consumer<UserController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.currentUser == null) {
            return const Center(
              child: Text("User not found"),
            );
          }

          final user = controller.currentUser!;

          return Padding(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: Column(
              children: [
                const SizedBox(height: 24),

                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      user.profileImage != null
                          ? NetworkImage(
                              user.profileImage!)
                          : null,
                  child: user.profileImage == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : null,
                ),

                const SizedBox(height: 16),

                Text(
                  user.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge,
                ),

                const SizedBox(height: 8),

                Text(
                  user.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                ),

                const SizedBox(height: 24),

                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.phone),
                    title: const Text("Phone"),
                    subtitle:
                        Text(user.phone ?? "Not added"),
                  ),
                ),

                const SizedBox(height: 16),

                Card(
                  child: ListTile(
                    leading:
                        const Icon(Icons.badge),
                    title: const Text("Role"),
                    subtitle:
                        Text(user.role ?? "User"),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.editProfile,
                      );
                    },
                    child: const Text(
                        AppStrings.editProfile),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

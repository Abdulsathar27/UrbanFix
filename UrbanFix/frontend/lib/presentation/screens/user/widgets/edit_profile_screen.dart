import 'package:flutter/material.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/user/widgets/primary_button.dart';
import 'package:frontend/presentation/screens/user/widgets/profile_text_field.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, _) {
        final user = controller.currentUser;

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text("User not found")),
          );
        }

        
        controller.nameController.text = user.name;
        controller.phoneController.text = user.phone ?? "";

        return Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
            leading:  IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.go('/profile'),
          ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Avatar
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.profileImage != null
                      ? NetworkImage(user.profileImage!)
                      : null,
                  child: user.profileImage == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),

                const SizedBox(height: 30),

                ProfileTextField(
                  controller: controller.nameController,
                  label: "Full Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                ProfileTextField(
                  controller: controller.phoneController,
                  label: "Phone Number",
                  icon: Icons.phone,
                ),
                const SizedBox(height: 40),

                PrimaryButton(
                  text: "Save Changes",
                  isLoading: controller.isLoading,
                  onPressed: () async {
                    final success = await controller.updateProfile(
                      name: controller.nameController.text.trim(),
                      phone: controller.phoneController.text.trim(),
                    );

                    if (!context.mounted) return;

                    if (!success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            controller.errorMessage ??
                                "Failed to update profile",
                          ),
                        ),
                      );
                      return;
                    }

                    context.pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
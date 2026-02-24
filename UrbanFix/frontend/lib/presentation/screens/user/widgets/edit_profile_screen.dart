import 'package:flutter/material.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/presentation/screens/user/widgets/primary_button.dart';
import 'package:frontend/presentation/screens/user/widgets/profile_text_field.dart';
import 'package:provider/provider.dart';


class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<UserController>();
    final user = controller.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User not found")),
      );
    }

    final nameController =
        TextEditingController(text: user.name);
    final phoneController =
        TextEditingController(text: user.phone ?? "");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Avatar Section
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      user.profileImage != null
                          ? NetworkImage(user.profileImage!)
                          : null,
                  child: user.profileImage == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                )
              ],
            ),

            const SizedBox(height: 30),

            /// Name Field
            ProfileTextField(
              controller: nameController,
              label: "Full Name",
              icon: Icons.person,
            ),

            const SizedBox(height: 20),

            /// Phone Field
            ProfileTextField(
              controller: phoneController,
              label: "Phone Number",
              icon: Icons.phone,
            ),

            const SizedBox(height: 40),

            /// Update Button
            PrimaryButton(
              text: "Save Changes",
              isLoading: controller.isLoading,
              onPressed: () async {
                await controller.updateProfile(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                );

                if (controller.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text(controller.errorMessage!)),
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
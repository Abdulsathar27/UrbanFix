import 'package:flutter/material.dart';
import 'package:frontend/data/controller/user_controller.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final user =
        context.read<UserController>().currentUser;

    if (user != null) {
      _nameController.text = user.name;
      _phoneController.text = user.phone ?? "";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate(
      UserController controller) async {
    if (!_formKey.currentState!.validate()) return;

    await controller.updateProfile(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    if (controller.errorMessage != null) {
      Helpers.showError(
        context,
        controller.errorMessage!,
      );
    } else {
      Helpers.showSuccess(
        context,
        "Profile updated successfully",
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(AppStrings.editProfile),
      ),
      body: Consumer<UserController>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(
                AppConstants.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                    validator: (value) =>
                        Validators.validateRequired(
                            value, "Name"),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                    ),
                    validator:
                        Validators.validatePhone,
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller
                              .isLoading
                          ? null
                          : () => _handleUpdate(
                              controller),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : const Text(
                              AppStrings.confirm),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

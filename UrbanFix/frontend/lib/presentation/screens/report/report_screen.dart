import 'package:flutter/material.dart';
import 'package:frontend/controller/report_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/helpers.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() =>
      _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reasonController =
      TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();

  String? reportedUserId;
  String? jobId;
  String? chatId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)
        ?.settings
        .arguments as Map<String, dynamic>?;

    if (args != null) {
      reportedUserId = args['reportedUserId'];
      jobId = args['jobId'];
      chatId = args['chatId'];
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport(
      ReportController controller) async {
    if (!_formKey.currentState!.validate()) return;

    await controller.createReport(
      reason: _reasonController.text.trim(),
      description:
          _descriptionController.text.trim(),
      reportedUserId: reportedUserId,
      jobId: jobId,
      chatId: chatId,
    );

    if (controller.errorMessage != null) {
      Helpers.showError(
        context,
        controller.errorMessage!,
      );
    } else {
      Helpers.showSuccess(
        context,
        "Report submitted successfully",
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
      ),
      body: Consumer<ReportController>(
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
                    controller: _reasonController,
                    decoration:
                        const InputDecoration(
                      labelText: "Reason",
                    ),
                    validator: (value) =>
                        Validators.validateRequired(
                            value, "Reason"),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller:
                        _descriptionController,
                    maxLines: 4,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Description (optional)",
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller
                              .isLoading
                          ? null
                          : () =>
                              _submitReport(
                                  controller),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                                color:
                                    Colors.white,
                              ),
                            )
                          : const Text(
                              "Submit Report"),
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

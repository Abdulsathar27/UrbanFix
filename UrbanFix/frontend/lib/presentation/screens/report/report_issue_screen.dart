import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/core/constants/app_colors.dart';
import 'package:frontend/core/constants/app_strings.dart';
import 'widgets/report_text_field.dart';
import 'widgets/photo_upload_section.dart';
import 'widgets/submit_button.dart';

class ReportIssueScreen extends StatelessWidget {
  const ReportIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back, color: AppColors.lightTextSecondary),
        ),
        centerTitle: true,
        title: const Text(
          AppStrings.reportAnIssue,
          style: TextStyle(color: AppColors.lightTextPrimary),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Heading
              const Text(
                AppStrings.reportHeading,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                AppStrings.reportSubheading,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.greyMedium,
                ),
              ),

              const SizedBox(height: 30),

              /// Issue Title
              const Text(
                AppStrings.issueTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const ReportTextField(
                hintText: AppStrings.issueTitleHint,
              ),

              const SizedBox(height: 25),

              /// Description
              const Text(
                AppStrings.description,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const ReportTextField(
                hintText: AppStrings.issueDescriptionHint,
                maxLines: 5,
              ),

              const SizedBox(height: 25),

              /// Photo Section
              const Text(
                AppStrings.visualEvidence,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 15),

              const PhotoUploadSection(),

              const Spacer(),

              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/report_text_field.dart';
import 'widgets/photo_upload_section.dart';
import 'widgets/submit_button.dart';

class ReportIssueScreen extends StatelessWidget {
  const ReportIssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        centerTitle: true,
        title: const Text(
          "Report an Issue",
          style: TextStyle(color: Colors.black),
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
                "Tell us what needs fixing",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Provide details about the urban issue you've encountered in your neighborhood.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              /// Issue Title
              const Text(
                "Issue Title",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const ReportTextField(
                hintText: "e.g., Pothole on Main St",
              ),

              const SizedBox(height: 25),

              /// Description
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              const ReportTextField(
                hintText:
                    "Describe the issue in detail. The more info the better...",
                maxLines: 5,
              ),

              const SizedBox(height: 25),

              /// Photo Section
              const Text(
                "Visual Evidence",
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
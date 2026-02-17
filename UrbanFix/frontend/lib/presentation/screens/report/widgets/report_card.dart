import 'package:flutter/material.dart';
import 'package:frontend/data/models/report_model.dart';
import 'report_status_badge.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
  final VoidCallback? onTap;

  const ReportCard({
    super.key,
    required this.report,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(
          report.reason,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          report.description ?? "No description",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: ReportStatusBadge(
          status: report.status,
        ),
      ),
    );
  }
}

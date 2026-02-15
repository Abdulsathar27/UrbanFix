import 'package:flutter/material.dart';

import '../../data/models/report_model.dart';
import '../../data/repositories/report_repository.dart';

class ReportController extends ChangeNotifier {
  final ReportRepository _repository = ReportRepository();

  List<ReportModel> _reports = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<ReportModel> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ==========================
  // Private Helpers
  // ==========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ==========================
  // Fetch Reports
  // ==========================
  Future<void> fetchReports() async {
    try {
      _setLoading(true);
      _setError(null);

      final data = await _repository.getReports();

      // Sort newest first
      data.sort((a, b) =>
          (b.createdAt ?? DateTime.now())
              .compareTo(a.createdAt ?? DateTime.now()));

      _reports = data;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Create Report
  // ==========================
  Future<void> createReport({
    required String reason,
    String? description,
    String? reportedUserId,
    String? jobId,
    String? chatId,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final newReport =
          await _repository.createReport(
        reason: reason,
        description: description,
        reportedUserId: reportedUserId,
        jobId: jobId,
        chatId: chatId,
      );

      _reports.insert(0, newReport);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Update Report Status
  // ==========================
  Future<void> updateReportStatus({
    required String reportId,
    required String status,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedReport =
          await _repository.updateReportStatus(
        reportId: reportId,
        status: status,
      );

      final index =
          _reports.indexWhere((r) => r.id == reportId);

      if (index != -1) {
        _reports[index] = updatedReport;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Delete Report
  // ==========================
  Future<void> deleteReport(String reportId) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repository.deleteReport(reportId);

      _reports.removeWhere(
          (r) => r.id == reportId);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Clear Reports (Optional)
  // ==========================
  void clearReports() {
    _reports = [];
    notifyListeners();
  }
}

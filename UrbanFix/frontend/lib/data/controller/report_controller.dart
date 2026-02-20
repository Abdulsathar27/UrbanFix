import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../../data/models/report_model.dart';
import '../../../../data/services/report_api_service.dart';

class ReportController extends ChangeNotifier {
  ReportApiService reportApiService = ReportApiService();

  // ==========================
  // State
  // ==========================
  List<ReportModel> _reports = [];
  ReportModel? _selectedReport;
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<ReportModel> get reports => _reports;
  ReportModel? get selectedReport => _selectedReport;
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

  String _extractErrorMessage(Object error) {
    if (error is DioException) {
      final responseData = error.response?.data;
      if (responseData is Map && responseData['message'] != null) {
        return responseData['message'].toString();
      }
      return error.message ?? "Request failed";
    }

    final text = error.toString();
    if (text.startsWith("Exception: ")) {
      return text.substring("Exception: ".length);
    }
    return text;
  }

  // ==========================
  // Fetch All Reports
  // ==========================
  Future<void> fetchReports() async {
    try {
      _setLoading(true);
      _setError(null);

      final data = await reportApiService.getReports();
      _reports = data;
    } catch (e) {
      _setError(_extractErrorMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Fetch Report By ID
  // ==========================
  Future<void> fetchReportById(String reportId) async {
    try {
      _setLoading(true);
      _setError(null);

      final report =
          await reportApiService.getReportById(reportId);

      _selectedReport = report;
    } catch (e) {
      _setError(_extractErrorMessage(e));
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Create Report
  // ==========================
  Future<bool> createReport({
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
          await reportApiService.createReport(
        reason: reason,
        description: description,
        reportedUserId: reportedUserId,
        jobId: jobId,
        chatId: chatId,
      );

      _reports.insert(0, newReport);
      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Update Report Status
  // ==========================
  Future<bool> updateReportStatus({
    required String reportId,
    required String status,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedReport =
          await reportApiService.updateReportStatus(
        reportId: reportId,
        status: status,
      );

      final index = _reports.indexWhere(
        (r) => r.id == reportId,
      );

      if (index != -1) {
        _reports[index] = updatedReport;
      }

      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Delete Report
  // ==========================
  Future<bool> deleteReport(String reportId) async {
    try {
      _setLoading(true);
      _setError(null);

      await reportApiService.deleteReport(reportId);

      _reports.removeWhere((r) => r.id == reportId);

      return true;
    } catch (e) {
      _setError(_extractErrorMessage(e));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Clear Error
  // ==========================
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

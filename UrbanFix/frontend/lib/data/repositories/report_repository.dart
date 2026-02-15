import 'package:frontend/data/services/dio_client.dart';
import 'package:frontend/data/services/report_api_service.dart';
import '../models/report_model.dart';

class ReportRepository {
  final ReportApiService _apiService;

  ReportRepository()
      : _apiService = ReportApiService(DioClient());

  // ==========================
  // Get All Reports
  // ==========================
  Future<List<ReportModel>> getReports() async {
    return await _apiService.getReports();
  }

  // ==========================
  // Get Report By ID
  // ==========================
  Future<ReportModel> getReportById(String reportId) async {
    return await _apiService.getReportById(reportId);
  }

  // ==========================
  // Create Report
  // ==========================
  Future<ReportModel> createReport({
    required String reason,
    String? description,
    String? reportedUserId,
    String? jobId,
    String? chatId,
  }) async {
    return await _apiService.createReport(
      reason: reason,
      description: description,
      reportedUserId: reportedUserId,
      jobId: jobId,
      chatId: chatId,
    );
  }

  // ==========================
  // Update Report Status
  // ==========================
  Future<ReportModel> updateReportStatus({
    required String reportId,
    required String status,
  }) async {
    return await _apiService.updateReportStatus(
      reportId: reportId,
      status: status,
    );
  }

  // ==========================
  // Delete Report
  // ==========================
  Future<void> deleteReport(String reportId) async {
    await _apiService.deleteReport(reportId);
  }
}

import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/report_model.dart';
import 'dio_client.dart';

class ReportApiService {
  final Dio _dio;

  ReportApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================
  // Get All Reports
  // ==========================
  Future<List<ReportModel>> getReports() async {
    final response = await _dio.get(
      ApiConstants.reports,
    );

    final List data = response.data;

    return data
        .map((json) => ReportModel.fromJson(json))
        .toList();
  }

  // ==========================
  // Get Report By ID
  // ==========================
  Future<ReportModel> getReportById(String reportId) async {
    final response = await _dio.get(
      "${ApiConstants.reports}/$reportId",
    );

    return ReportModel.fromJson(response.data);
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
    final response = await _dio.post(
      ApiConstants.reports,
      data: {
        "reason": reason,
        "description": description,
        "reportedUserId": reportedUserId,
        "jobId": jobId,
        "chatId": chatId,
      },
    );

    return ReportModel.fromJson(response.data);
  }

  // ==========================
  // Update Report Status
  // ==========================
  Future<ReportModel> updateReportStatus({
    required String reportId,
    required String status,
  }) async {
    final response = await _dio.put(
      "${ApiConstants.reports}/$reportId/status",
      data: {
        "status": status,
      },
    );

    return ReportModel.fromJson(response.data);
  }

  // ==========================
  // Delete Report
  // ==========================
  Future<void> deleteReport(String reportId) async {
    await _dio.delete(
      "${ApiConstants.reports}/$reportId",
    );
  }
}

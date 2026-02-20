import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/report_model.dart';
import 'dio_client.dart';

class ReportApiService {
  final Dio _dio = DioClient().dio;

  // ==========================
  // Get All Reports
  // ==========================
  Future<List<ReportModel>> getReports() async {
    try {
      final response =
          await _dio.get(ApiConstants.reports);

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch reports");
      }

      final data = response.data;

      if (data is! List) {
        throw Exception("Invalid reports response");
      }

      return data
          .map((json) =>
              ReportModel.fromJson(
                Map<String, dynamic>.from(json),
              ))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to fetch reports",
      );
    }
  }

  // ==========================
  // Get Report By ID
  // ==========================
  Future<ReportModel> getReportById(
      String reportId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.reports}/$reportId",
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch report");
      }

      return ReportModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to fetch report",
      );
    }
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
    try {
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

      if (response.statusCode != 200 &&
          response.statusCode != 201) {
        throw Exception("Failed to create report");
      }

      return ReportModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to create report",
      );
    }
  }

  // ==========================
  // Update Report Status
  // ==========================
  Future<ReportModel> updateReportStatus({
    required String reportId,
    required String status,
  }) async {
    try {
      final response = await _dio.put(
        "${ApiConstants.reports}/$reportId/status",
        data: {
          "status": status,
        },
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to update report");
      }

      return ReportModel.fromJson(
        Map<String, dynamic>.from(response.data),
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to update report",
      );
    }
  }

  // ==========================
  // Delete Report
  // ==========================
  Future<void> deleteReport(String reportId) async {
    try {
      final response = await _dio.delete(
        "${ApiConstants.reports}/$reportId",
      );

      if (response.statusCode != 200 &&
          response.statusCode != 204) {
        throw Exception("Failed to delete report");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ??
            "Failed to delete report",
      );
    }
  }
}

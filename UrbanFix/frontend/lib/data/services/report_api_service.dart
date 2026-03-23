import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/report_model.dart';
import 'dio_client.dart';

class ReportApiService {
  final Dio _dio = DioClient().dio;
  Future<List<ReportModel>> getReports() async {
    try {
      final response = await _dio.get(ApiConstants.reports);

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch reports");
      }

      final data = response.data;

      if (data is! List) {
        throw Exception("Invalid reports response");
      }

      return data
          .map((json) => ReportModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to fetch reports");
    }
  }

  
  Future<List<ReportModel>> getReportById(String reportId) async {
    try {
      final response = await _dio.get("${ApiConstants.reports}/$reportId");

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch report");
      }
      final data = response.data;

      if (data is! List) {
        throw Exception("Invalid report response");
      }

      return data
          .map((json) => ReportModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to fetch report");
    }
  }

  Future<List<ReportModel>> createReport(String reason, String? description, String? reportedUserId, String? jobId, String? chatId) async {
    try {
      final response = await _dio.post('${ApiConstants.reports}/create', data: {
        "reason": reason,
        "description": description,
        "reportedUserId": reportedUserId,
        "jobId": jobId,
        "chatId": chatId
      });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Failed to create report");
      }

      final data = response.data;

      if (data is! List) {
        throw Exception("Invalid report response");
      }

      return data
          .map((json) => ReportModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to create report");
    }
  }

  
  Future<List<ReportModel>> updateReportStatus(String reportId, String status) async {
    try {
      final response = await _dio.put("${ApiConstants.reports}/$reportId/status", data: {"status": status});

      if (response.statusCode != 200) {
        throw Exception("Failed to update report");
      }

      final data = response.data;

      if (data is! List) {
        throw Exception("Invalid report response");
      }

      return data
          .map((json) => ReportModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to update report");
    }
  }

 
  Future<List<ReportModel>> deleteReport(String reportId) async {
    try {
      final response = await _dio.delete("${ApiConstants.reports}/$reportId");

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception("Failed to delete report");
      }

      final data = response.data;

      if (data is! List) {
        throw Exception("Invalid report response");
      }

      return data
          .map((json) => ReportModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to delete report");
    }
  }
}

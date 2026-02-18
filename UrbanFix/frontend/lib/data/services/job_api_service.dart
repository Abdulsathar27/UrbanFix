import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/job_model.dart';
import 'dio_client.dart';

class JobApiService {
  final Dio _dio;

  JobApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================================================
  // Get All Jobs
  // ==========================================================
  Future<List<JobModel>> getJobs() async {
    try {
      final response = await _dio.get(ApiConstants.jobs);

      final List<dynamic> data =
          response.data as List<dynamic>;

      return data
          .map((json) =>
              JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch jobs: ${e.message}");
    }
  }

  // ==========================================================
  // Get Job By ID
  // ==========================================================
  Future<JobModel> getJobById(String jobId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.jobs}/$jobId",
      );

      return JobModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to fetch job: ${e.message}");
    }
  }

  // ==========================================================
  // Create Job
  // ==========================================================
  Future<JobModel> createJob({
    required String title,
    required String description,
    required String category,
    required String location,
    double? budget,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.jobs,
        data: {
          "title": title,
          "description": description,
          "category": category,
          "location": location,
          if (budget != null) "budget": budget,
        },
      );

      return JobModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to create job: ${e.message}");
    }
  }

  // ==========================================================
  // Update Job
  // ==========================================================
  Future<JobModel> updateJob({
    required String jobId,
    String? title,
    String? description,
    String? category,
    String? location,
    double? budget,
  }) async {
    try {
      final Map<String, dynamic> updateData = {
        if (title != null) "title": title,
        if (description != null) "description": description,
        if (category != null) "category": category,
        if (location != null) "location": location,
        if (budget != null) "budget": budget,
      };

      final response = await _dio.put(
        "${ApiConstants.jobs}/$jobId",
        data: updateData,
      );

      return JobModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to update job: ${e.message}");
    }
  }

  // ==========================================================
  // Update Job Status
  // ==========================================================
  Future<JobModel> updateJobStatus({
    required String jobId,
    required String status,
  }) async {
    try {
      final response = await _dio.put(
        "${ApiConstants.jobs}/$jobId/status",
        data: {"status": status},
      );

      return JobModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to update job status: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Job
  // ==========================================================
  Future<void> deleteJob(String jobId) async {
    try {
      await _dio.delete(
        "${ApiConstants.jobs}/$jobId",
      );
    } on DioException catch (e) {
      throw Exception("Failed to delete job: ${e.message}");
    }
  }
}

import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/job_model.dart';
import 'dio_client.dart';

class JobApiService {
  final Dio _dio = DioClient().dio;

  // ==========================================================
  // Get All Jobs
  // ==========================================================
  Future<List<JobModel>> getJobs() async {
    try {
      final response = await _dio.get(ApiConstants.jobs);

      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch jobs: ${e.message}");
    }
  }

  // ==========================================================
  // Get Job By ID
  // ==========================================================
  Future<List<JobModel>> getJobById(String jobId) async {
    try {
      final response = await _dio.get("${ApiConstants.jobs}/$jobId");
      final List<dynamic> data = response.data['jobs'] as List<dynamic>;
      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch job: ${e.message}");
    }
  }

  // ==========================================================
  // Create Job
  // ==========================================================
  Future<List<JobModel>> createJob(String? title, String? description, String? category, String? location, double? budget) async {
    try {
      final response = await _dio.post('${ApiConstants.jobs}/create',
        data: {
          "title": title,
          "description": description,
          "category": category,
          "location": location,
          "budget": budget
        }
      );

      final List<dynamic> data = response.data['jobs'] as List<dynamic>;
      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to create job: ${e.message}");
    }
  }

  // ==========================================================
  // Update Job
  // ==========================================================
  Future<List<JobModel>> updateJob(String? jobId,String? title,String? description,String? category,String? location,double? budget) async {
    try {
      final response = await _dio.put("${ApiConstants.jobs}/$jobId/update",
        data: {
          "title": title,
          "description": description,
          "category": category,
          "location": location,
          "budget": budget
        }
      );

      final List<dynamic> data = response.data['jobs'] as List<dynamic>;
      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to update job: ${e.message}");
    }
  }

  // ==========================================================
  // Update Job Status
  // ==========================================================
  Future<List<JobModel>> updateJobStatus(String jobId, String status) async {
    try {
      final response = await _dio.put("${ApiConstants.jobs}/$jobId/status",
        data: {
          "status": status
        }
      );
      final List<dynamic> data = response.data['jobs'] as List<dynamic>;
      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to update job status: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Job
  // ==========================================================
  Future<List<JobModel>> deleteJob(String jobId) async {
    try {
      final response = await _dio.delete("${ApiConstants.jobs}/$jobId");
      final List<dynamic> data = response.data['jobs'] as List<dynamic>;
      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to delete job: ${e.message}");
    }
  }
}

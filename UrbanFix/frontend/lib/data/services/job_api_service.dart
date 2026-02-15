import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/job_model.dart';
import 'dio_client.dart';

class JobApiService {
  final Dio _dio;

  JobApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================
  // Get All Jobs
  // ==========================
  Future<List<JobModel>> getJobs() async {
    final response = await _dio.get(
      ApiConstants.jobs,
    );

    final List data = response.data;

    return data
        .map((json) => JobModel.fromJson(json))
        .toList();
  }

  // ==========================
  // Get Job By ID
  // ==========================
  Future<JobModel> getJobById(String jobId) async {
    final response = await _dio.get(
      "${ApiConstants.jobs}/$jobId",
    );

    return JobModel.fromJson(response.data);
  }

  // ==========================
  // Create Job
  // ==========================
  Future<JobModel> createJob({
    required String title,
    required String description,
    required String category,
    required String location,
    double? budget,
  }) async {
    final response = await _dio.post(
      ApiConstants.jobs,
      data: {
        "title": title,
        "description": description,
        "category": category,
        "location": location,
        "budget": budget,
      },
    );

    return JobModel.fromJson(response.data);
  }

  // ==========================
  // Update Job
  // ==========================
  Future<JobModel> updateJob({
    required String jobId,
    String? title,
    String? description,
    String? category,
    String? location,
    double? budget,
  }) async {
    final response = await _dio.put(
      "${ApiConstants.jobs}/$jobId",
      data: {
        "title": title,
        "description": description,
        "category": category,
        "location": location,
        "budget": budget,
      },
    );

    return JobModel.fromJson(response.data);
  }

  // ==========================
  // Update Job Status
  // ==========================
  Future<JobModel> updateJobStatus({
    required String jobId,
    required String status,
  }) async {
    final response = await _dio.put(
      "${ApiConstants.jobs}/$jobId/status",
      data: {
        "status": status,
      },
    );

    return JobModel.fromJson(response.data);
  }

  // ==========================
  // Delete Job
  // ==========================
  Future<void> deleteJob(String jobId) async {
    await _dio.delete(
      "${ApiConstants.jobs}/$jobId",
    );
  }
}

import 'package:frontend/data/services/dio_client.dart';
import 'package:frontend/data/services/job_api_service.dart';
import '../models/job_model.dart';

class JobRepository {
  final JobApiService _apiService;

  JobRepository()
      : _apiService = JobApiService(DioClient());

  // ==========================
  // Get All Jobs
  // ==========================
  Future<List<JobModel>> getJobs() async {
    return await _apiService.getJobs();
  }

  // ==========================
  // Get Job By ID
  // ==========================
  Future<JobModel> getJobById(String jobId) async {
    return await _apiService.getJobById(jobId);
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
    return await _apiService.createJob(
      title: title,
      description: description,
      category: category,
      location: location,
      budget: budget,
    );
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
    return await _apiService.updateJob(
      jobId: jobId,
      title: title,
      description: description,
      category: category,
      location: location,
      budget: budget,
    );
  }

  // ==========================
  // Update Job Status
  // ==========================
  Future<JobModel> updateJobStatus({
    required String jobId,
    required String status,
  }) async {
    return await _apiService.updateJobStatus(
      jobId: jobId,
      status: status,
    );
  }

  // ==========================
  // Delete Job
  // ==========================
  Future<void> deleteJob(String jobId) async {
    await _apiService.deleteJob(jobId);
  }
}

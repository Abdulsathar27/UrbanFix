import 'package:flutter/material.dart';

import '../../../../data/models/job_model.dart';
import '../../../../data/services/job_api_service.dart';

class JobController extends ChangeNotifier {
  final JobApiService _apiService;

  JobController(this._apiService);

  List<JobModel> _jobs = [];
  JobModel? _selectedJob;
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<JobModel> get jobs => _jobs;
  JobModel? get selectedJob => _selectedJob;
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
  // Fetch All Jobs
  // ==========================
  Future<void> fetchJobs() async {
    try {
      _setLoading(true);
      _setError(null);

      _jobs = await _apiService.getJobs();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Fetch Single Job
  // ==========================
  Future<void> fetchJobById(String jobId) async {
    try {
      _setLoading(true);
      _setError(null);

      _selectedJob =
          await _apiService.getJobById(jobId);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Create Job
  // ==========================
  Future<void> createJob({
    required String title,
    required String description,
    required String category,
    required String location,
    double? budget,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final newJob = await _apiService.createJob(
        title: title,
        description: description,
        category: category,
        location: location,
        budget: budget,
      );

      _jobs.add(newJob);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Update Job
  // ==========================
  Future<void> updateJob({
    required String jobId,
    String? title,
    String? description,
    String? category,
    String? location,
    double? budget,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedJob = await _apiService.updateJob(
        jobId: jobId,
        title: title,
        description: description,
        category: category,
        location: location,
        budget: budget,
      );

      final index =
          _jobs.indexWhere((job) => job.id == jobId);

      if (index != -1) {
        _jobs[index] = updatedJob;
      }

      if (_selectedJob?.id == jobId) {
        _selectedJob = updatedJob;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Update Job Status
  // ==========================
  Future<void> updateJobStatus({
    required String jobId,
    required String status,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedJob =
          await _apiService.updateJobStatus(
        jobId: jobId,
        status: status,
      );

      final index =
          _jobs.indexWhere((job) => job.id == jobId);

      if (index != -1) {
        _jobs[index] = updatedJob;
      }

      if (_selectedJob?.id == jobId) {
        _selectedJob = updatedJob;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Delete Job
  // ==========================
  Future<void> deleteJob(String jobId) async {
    try {
      _setLoading(true);
      _setError(null);

      await _apiService.deleteJob(jobId);

      _jobs.removeWhere((job) => job.id == jobId);

      if (_selectedJob?.id == jobId) {
        _selectedJob = null;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}

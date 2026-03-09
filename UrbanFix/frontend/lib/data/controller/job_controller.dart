import 'package:flutter/material.dart';

import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/data/services/job_api_service.dart';

class JobController extends ChangeNotifier {
  JobApiService jobApiService = JobApiService();

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
    _jobs = await jobApiService.getJobs();
    notifyListeners(); // ✅ tell UI jobs are ready
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

    final jobs = await jobApiService.getJobById(jobId); // returns List<JobModel>

    if (jobs.isEmpty) {
      _setError("Job not found");
      _selectedJob = null;
    } else {
      _selectedJob = jobs.first; // take the first job
    }
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

      final newJob = await jobApiService.createJob(
        title,
        description,
         category,
        location,
        budget,
      );

      _jobs.add(newJob.first);
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

      final updatedJob = await jobApiService.updateJob(
         jobId,
         title,
         description,
         category,
         location,
         budget,
      );

      final index = _jobs.indexWhere((job) => job.id == jobId);

      if (index != -1) {
        _jobs[index] = updatedJob.first;
      }

      if (_selectedJob?.id == jobId) {
        _selectedJob = updatedJob.first;
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

      final updatedJob = await jobApiService.updateJobStatus(
     jobId,
         status,
      );

      final index = _jobs.indexWhere((job) => job.id == jobId);

      if (index != -1) {
        _jobs[index] = updatedJob.first;
      }

      if (_selectedJob?.id == jobId) {
        _selectedJob = updatedJob.first;
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

      await jobApiService.deleteJob(jobId);

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

  Future<void> loadJobs() async {
  await fetchJobs();
}


}

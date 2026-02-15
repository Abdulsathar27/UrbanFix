import 'package:flutter/material.dart';

import '../../data/models/job_model.dart';
import '../../data/repositories/job_repository.dart';

class JobController extends ChangeNotifier {
  final JobRepository _repository = JobRepository();

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

      final data = await _repository.getJobs();
      _jobs = data;
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

      final job = await _repository.getJobById(jobId);
      _selectedJob = job;
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

      final newJob = await _repository.createJob(
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

      final updatedJob = await _repository.updateJob(
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
          await _repository.updateJobStatus(
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

      await _repository.deleteJob(jobId);

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

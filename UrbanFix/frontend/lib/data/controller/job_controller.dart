import 'package:flutter/material.dart';
import 'package:frontend/data/models/job_model.dart';
import 'package:frontend/data/services/job_api_service.dart';

class JobController extends ChangeNotifier {
  final JobApiService _jobApiService = JobApiService();

 
  List<JobModel> _allJobs = [];           
  List<JobModel> _filteredJobs = [];      
  JobModel? _selectedJob;
  
  bool _isLoading = false;
  String? _errorMessage;
  
  String? _currentCategory;            

 
  List<JobModel> get jobs => _allJobs;
  List<JobModel> get filteredJobs => _filteredJobs;
  JobModel? get selectedJob => _selectedJob;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get currentCategory => _currentCategory;
  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    if (_errorMessage == message) return;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _setError(null);
  }

  
  Future<void> fetchJobs() async {
    try {
      _setLoading(true);
      _setError(null);
      
     
      final response = await _jobApiService.getJobs();
      
      final List<dynamic> jobsData = response['jobs'] ?? [];
      _allJobs = jobsData
          .map((job) => JobModel.fromJson(job as Map<String, dynamic>))
          .toList();
      
     
      if (_currentCategory != null) {
        _filterByCategory(_currentCategory!);
      }
      
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch jobs: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  
  void filterJobsByCategory(String category) {
    _currentCategory = category;
    _filterByCategory(category);
  }

  void _filterByCategory(String category) {
    
    _filteredJobs = _allJobs
        .where((job) =>
            job.category.trim().toLowerCase() ==
            category.trim().toLowerCase())
        .toList();
    
    notifyListeners();
  }

 
  Future<void> fetchJobById(String jobId) async {
    try {
      _setLoading(true);
      _setError(null);

      final job = await _jobApiService.getJobById(jobId);
      _selectedJob = job;
      
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  
  Future<Map<String, dynamic>> fetchLatestJobs({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final response = await _jobApiService.getLatestJobs(
        page: page,
        limit: limit,
      );

      final List<dynamic> jobsData = response['jobs'] ?? [];
      _allJobs = jobsData
          .map((job) => JobModel.fromJson(job as Map<String, dynamic>))
          .toList();

      notifyListeners();
      return response;
    } catch (e) {
      _setError(e.toString());
      return {};
    } finally {
      _setLoading(false);
    }
  }

 
  Future<void> fetchNearbyJobs({
    required double lat,
    required double lng,
    double radius = 10,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final response = await _jobApiService.getNearbyJobs(
        lat: lat,
        lng: lng,
        radius: radius,
      );

      final List<dynamic> jobsData = response['jobs'] ?? [];
      _allJobs = jobsData
          .map((job) => JobModel.fromJson(job as Map<String, dynamic>))
          .toList();

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

 
  bool validateJobSelection(JobModel job) {
    if (job.isBlocked) {
      _setError('This job is blocked');
      return false;
    }
    
    clearError();
    return true;
  }

  
  Map<String, dynamic> prepareJobForBooking(JobModel job) {
   
    final workerId = job.user?['_id']?.toString() ??
        job.user?['id']?.toString() ??
        '';

    return {
      'jobId': job.id,
      'workerId': workerId,
      'category': job.category,
      'workTitle': job.title,
      'requestedWage': double.tryParse(job.wage) ?? 0.0,
      'description': job.description,
    };
  }

  
  void clearSelectedJob() {
    _selectedJob = null;
    notifyListeners();
  }

  
  void reset() {
    _allJobs = [];
    _filteredJobs = [];
    _selectedJob = null;
    _isLoading = false;
    _errorMessage = null;
    _currentCategory = null;
    notifyListeners();
  }
}
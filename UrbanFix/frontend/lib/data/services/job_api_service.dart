import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/job_model.dart';
import 'dio_client.dart';

class JobApiService {
  final Dio _dio = DioClient().dio;

  // ✅ GET ALL JOBS - Matches backend /api/jobs GET
  Future<Map<String, dynamic>> getJobs({
    int page = 1,
    int limit = 10,
    String? search,
    String? location,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'limit': limit,
        if (search != null) 'search': search,
        if (location != null) 'location': location,
      };

      final response = await _dio.get(
        '${ApiConstants.baseUrl}/jobs',
        queryParameters: queryParams,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to fetch jobs: ${e.message}");
    }
  }

  // ✅ GET JOB BY ID - Matches backend /api/jobs/:id GET
  Future<JobModel> getJobById(String jobId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/jobs/$jobId',
      );

      return JobModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to fetch job: ${e.message}");
    }
  }

  // ✅ GET LATEST JOBS - Matches backend /api/jobs/latest GET
  Future<Map<String, dynamic>> getLatestJobs({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/jobs/latest',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to fetch latest jobs: ${e.message}");
    }
  }

  // ✅ GET JOBS BY USER - Matches backend /api/jobs/user/:userId GET
  Future<List<JobModel>> getJobsByUser(String userId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/jobs/user/$userId',
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch user jobs: ${e.message}");
    }
  }

  // ✅ GET NEARBY JOBS - Matches backend /api/jobs/nearby GET
  Future<Map<String, dynamic>> getNearbyJobs({
    required double lat,
    required double lng,
    double radius = 10,
  }) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/jobs/nearby',
        queryParameters: {
          'lat': lat,
          'lng': lng,
          'radius': radius,
        },
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to fetch nearby jobs: ${e.message}");
    }
  }

  // ✅ CREATE JOB - Matches backend /api/jobs POST
  Future<JobModel> createJob({
    required String title,
    required String description,
    required String category,
    required String location,
    required String jobDuration,
    required List<String> skills,
    required String wage,
    required String phone,
    double? lat,
    double? lng,
    List<String>? images,
  }) async {
    try {
      final payload = {
        "title": title,
        "description": description,
        "category": category,
        "location": location,
        "jobDuration": jobDuration,
        "skills": skills,
        "wage": wage,
        "phone": phone,
        if (lat != null) "lat": lat,
        if (lng != null) "lng": lng,
        if (images != null) "images": images,
      };

      final response = await _dio.post(
        '${ApiConstants.baseUrl}/jobs',
        data: payload,
      );

      return JobModel.fromJson(response.data['job'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to create job: ${e.message}");
    }
  }

  // ✅ UPDATE JOB - Matches backend /api/jobs/:id PUT
  Future<JobModel> updateJob({
    required String jobId,
    String? title,
    String? description,
    String? category,
    String? location,
    String? jobDuration,
    List<String>? skills,
    String? wage,
    String? phone,
  }) async {
    try {
      final payload = {
        if (title != null) "title": title,
        if (description != null) "description": description,
        if (category != null) "category": category,
        if (location != null) "location": location,
        if (jobDuration != null) "jobDuration": jobDuration,
        if (skills != null) "skills": skills,
        if (wage != null) "wage": wage,
        if (phone != null) "phone": phone,
      };

      final response = await _dio.put(
        '${ApiConstants.baseUrl}/jobs/$jobId',
        data: payload,
      );

      return JobModel.fromJson(response.data['job'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to update job: ${e.message}");
    }
  }

  // ✅ DELETE JOB - Matches backend /api/jobs/:id DELETE
  Future<void> deleteJob(String jobId) async {
    try {
      await _dio.delete('${ApiConstants.baseUrl}/jobs/$jobId');
    } on DioException catch (e) {
      throw Exception("Failed to delete job: ${e.message}");
    }
  }

  // ✅ ADD REVIEW - Matches backend /api/jobs/:id/reviews POST
  Future<void> addReview({
    required String jobId,
    required int rating,
    String? comment,
  }) async {
    try {
      await _dio.post(
        '${ApiConstants.baseUrl}/jobs/$jobId/reviews',
        data: {
          "rating": rating,
          if (comment != null) "comment": comment,
        },
      );
    } on DioException catch (e) {
      throw Exception("Failed to add review: ${e.message}");
    }
  }

  // ✅ GET REVIEWS - Matches backend /api/jobs/:id/reviews GET
  Future<List<Map<String, dynamic>>> getReviews(String jobId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/jobs/$jobId/reviews',
      );

      return List<Map<String, dynamic>>.from(response.data as List<dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to fetch reviews: ${e.message}");
    }
  }
}
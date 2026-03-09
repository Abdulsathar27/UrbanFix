import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/appointment_model.dart';
import 'dio_client.dart';

class AppointmentApiService {
  final Dio _dio = DioClient().dio;

  // ==========================================================
  // Get Sent Appointments (user as customer)
  // ==========================================================
  Future<List<AppointmentModel>> getSentAppointments() async {
    try {
      final response = await _dio.get('${ApiConstants.appointments}/sent');
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch sent appointments: ${e.message}");
    }
  }

  // ==========================================================
  // Get Received Appointments (user as worker)
  // ==========================================================
  Future<List<AppointmentModel>> getReceivedAppointments() async {
    try {
      final response = await _dio.get('${ApiConstants.appointments}/received');
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch received appointments: ${e.message}");
    }
  }

  // ==========================================================
  // Create Appointment
  // ==========================================================
  Future<List<AppointmentModel>> createAppointment(String workerId, String jobId, String workTitle, String date, String time, double requestedWage, String? description) async {
    try {
      final response = await _dio.post('${ApiConstants.appointments}/create', data: {
        'workerId': workerId,
        'jobId': jobId,
        'workTitle': workTitle,
        'date': date,
        'time': time,
        'requestedWage': requestedWage,
        'description': description
      });
      final List<dynamic> data = response.data['appointments'] as List<dynamic>;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to create appointment: ${e.message}");
    }
  }

  // ==========================================================
  // Update Appointment Status
  // ==========================================================
  Future<List<AppointmentModel>> updateStatus(String appointmentId, String status, String? reason) async {
    try {
      final response = await _dio.patch('${ApiConstants.appointments}/status', data: {
        'appointmentId': appointmentId,
        'status': status,
        'reason': reason
      });
      final List<dynamic> data = response.data['appointments'] as List<dynamic>;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to update status: ${e.message}");
    }
  }

  // ==========================================================
  // Cancel Appointment (by user or worker)
  // ==========================================================
  Future<List<AppointmentModel>> cancelAppointment(String appointmentId, String reason) async {
    try {
      final response = await _dio.patch('${ApiConstants.appointments}/cancel', data: {
        'appointmentId': appointmentId,
        'reason': reason
      });
      final List<dynamic> data = response.data['appointments'] as List<dynamic>;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to cancel appointment: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Appointment (only rejected)
  // ==========================================================
  Future<List<AppointmentModel>> deleteAppointment(String appointmentId) async {
    try {
      final response = await _dio.delete(
        '${ApiConstants.appointments}/$appointmentId',
      );
      final List<dynamic> data = response.data['appointments'] as List<dynamic>;
      return data.map((json) => AppointmentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to delete appointment: ${e.message}");
    }
  }

  // ==========================================================
  // Get Worker Accepted Slots (to disable times)
  // ==========================================================
  Future<List<Map<String, String>>> getWorkerAcceptedSlots(
    String workerId,
  ) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.appointments}/worker/$workerId/accepted',
      );
      // Response is list of { date, time }
      return List<Map<String, String>>.from(response.data);
    } on DioException catch (e) {
      throw Exception("Failed to fetch accepted slots: ${e.message}");
    }
  }
}

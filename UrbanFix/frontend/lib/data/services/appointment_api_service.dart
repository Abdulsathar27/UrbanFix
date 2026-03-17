import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/appointment_model.dart';
import 'dio_client.dart';

class AppointmentApiService {
  final Dio _dio = DioClient().dio;

  // ✅ CREATE APPOINTMENT - Matches backend POST /api/appointments
  Future<AppointmentModel> createAppointment(AppointmentModel appointment) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/appointments',
        data: {
          'workerId': appointment.workerId,
          'jobId': appointment.jobId,
          'workTitle': appointment.workTitle,
          'date': appointment.date,
          'time': appointment.time,
          'requestedWage': appointment.requestedWage,
          if (appointment.description != null)
            'description': appointment.description,
        },
      );

      return AppointmentModel.fromJson(
        response.data['appointment'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception("Failed to create appointment: ${e.message}");
    }
  }

  // ✅ GET SENT APPOINTMENTS - Matches backend GET /api/appointments/sent
  Future<List<AppointmentModel>> getSentAppointments() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/appointments/sent',
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => AppointmentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch sent appointments: ${e.message}");
    }
  }

  // ✅ GET RECEIVED APPOINTMENTS - Matches backend GET /api/appointments/received
  Future<List<AppointmentModel>> getReceivedAppointments() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/appointments/received',
      );

      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => AppointmentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
          "Failed to fetch received appointments: ${e.message}");
    }
  }

  // ✅ UPDATE APPOINTMENT STATUS - Matches backend PATCH /api/appointments/:id/status
  Future<AppointmentModel> updateStatus(
    AppointmentModel appointment, {
    String? reason,
  }) async {
    try {
      final payload = {
        "status": appointment.status,
        if (reason != null) "reason": reason,
      };

      final response = await _dio.patch(
        '${ApiConstants.baseUrl}/appointments/${appointment.id}/status',
        data: payload,
      );

      return AppointmentModel.fromJson(
        response.data['appointment'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception("Failed to update appointment status: ${e.message}");
    }
  }

  // ✅ CANCEL APPOINTMENT - Matches backend PATCH /api/appointments/:id/cancel
  Future<void> cancelAppointment({
    required String appointmentId,
    required String reason,
  }) async {
    try {
      await _dio.patch(
        '${ApiConstants.baseUrl}/appointments/$appointmentId/cancel',
        data: {
          "reason": reason,
        },
      );
    } on DioException catch (e) {
      throw Exception("Failed to cancel appointment: ${e.message}");
    }
  }

  // ✅ DELETE APPOINTMENT - Matches backend DELETE /api/appointments/:id
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _dio.delete(
        '${ApiConstants.baseUrl}/appointments/$appointmentId',
      );
    } on DioException catch (e) {
      throw Exception("Failed to delete appointment: ${e.message}");
    }
  }

  // ✅ GET WORKER ACCEPTED SLOTS - Matches backend GET /api/appointments/worker/:workerId/accepted
  Future<List<Map<String, String>>> getWorkerAcceptedSlots(
    String workerId,
  ) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/appointments/worker/$workerId/accepted',
      );

      return List<Map<String, String>>.from(response.data as List<dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to fetch accepted slots: ${e.message}");
    }
  }

  // ✅ GET CHAT PERMISSION - Matches backend GET /api/appointments/:appointmentId/chat-permission
  Future<Map<String, dynamic>> getChatPermission(String appointmentId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/appointments/$appointmentId/chat-permission',
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to get chat permission: ${e.message}");
    }
  }
}
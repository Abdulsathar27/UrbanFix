import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/appointment_model.dart';
import 'dio_client.dart';

class AppointmentApiService {
  final Dio _dio = DioClient().dio;

  // ==========================================================
  // Get All Appointments
  // ==========================================================
  Future<List<AppointmentModel>> getAppointments() async {
    try {
      final response = await _dio.get(ApiConstants.appointments);

      final List<dynamic> data = response.data as List<dynamic>;

      return data
          .map((json) =>
              AppointmentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch appointments: ${e.message}");
    }
  }

  // ==========================================================
  // Get Single Appointment
  // ==========================================================
  Future<AppointmentModel> getAppointmentById(
      String appointmentId) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.appointments}/$appointmentId",
      );

      return AppointmentModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to fetch appointment: ${e.message}");
    }
  }

  // ==========================================================
  // Create Appointment
  // ==========================================================
  Future<AppointmentModel> createAppointment({
    required String jobId,
    required String serviceProviderId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.createAppointment,
        data: {
          "jobId": jobId,
          "serviceProviderId": serviceProviderId,
          "appointmentDate":
              appointmentDate.toIso8601String(),
          "timeSlot": timeSlot,
          if (notes != null) "notes": notes,
        },
      );

      return AppointmentModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to create appointment: ${e.message}");
    }
  }

  // ==========================================================
  // Update Appointment Status
  // ==========================================================
  Future<AppointmentModel> updateStatus({
    required String appointmentId,
    required String status,
  }) async {
    try {
      final response = await _dio.put(
        "${ApiConstants.appointments}/$appointmentId",
        data: {"status": status},
      );

      return AppointmentModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception("Failed to update status: ${e.message}");
    }
  }

  // ==========================================================
  // Delete Appointment
  // ==========================================================
  Future<void> deleteAppointment(
      String appointmentId) async {
    try {
      await _dio.delete(
        "${ApiConstants.appointments}/$appointmentId",
      );
    } on DioException catch (e) {
      throw Exception("Failed to delete appointment: ${e.message}");
    }
  }
}

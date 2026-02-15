import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../models/appointment_model.dart';
import 'dio_client.dart';

class AppointmentApiService {
  final Dio _dio;

  AppointmentApiService(DioClient dioClient)
      : _dio = dioClient.dio;

  // ==========================
  // Get All Appointments
  // ==========================
  Future<List<AppointmentModel>> getAppointments() async {
    final response = await _dio.get(
      ApiConstants.appointments,
    );

    final List data = response.data;

    return data
        .map((json) => AppointmentModel.fromJson(json))
        .toList();
  }

  // ==========================
  // Get Single Appointment
  // ==========================
  Future<AppointmentModel> getAppointmentById(
      String appointmentId) async {
    final response = await _dio.get(
      "${ApiConstants.appointments}/$appointmentId",
    );

    return AppointmentModel.fromJson(response.data);
  }

  // ==========================
  // Create Appointment
  // ==========================
  Future<AppointmentModel> createAppointment({
    required String jobId,
    required String serviceProviderId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    final response = await _dio.post(
      ApiConstants.createAppointment,
      data: {
        "jobId": jobId,
        "serviceProviderId": serviceProviderId,
        "appointmentDate":
            appointmentDate.toIso8601String(),
        "timeSlot": timeSlot,
        "notes": notes,
      },
    );

    return AppointmentModel.fromJson(response.data);
  }

  // ==========================
  // Update Appointment Status
  // ==========================
  Future<AppointmentModel> updateStatus({
    required String appointmentId,
    required String status,
  }) async {
    final response = await _dio.put(
      "${ApiConstants.appointments}/$appointmentId",
      data: {
        "status": status,
      },
    );

    return AppointmentModel.fromJson(response.data);
  }

  // ==========================
  // Delete Appointment
  // ==========================
  Future<void> deleteAppointment(
      String appointmentId) async {
    await _dio.delete(
      "${ApiConstants.appointments}/$appointmentId",
    );
  }
}

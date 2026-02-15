import 'package:frontend/data/services/appointment_api_service.dart';
import 'package:frontend/data/services/dio_client.dart';
import '../models/appointment_model.dart';

class AppointmentRepository {
  final AppointmentApiService _apiService;

  AppointmentRepository()
      : _apiService = AppointmentApiService(DioClient());

  // ==========================
  // Get All Appointments
  // ==========================
  Future<List<AppointmentModel>> getAppointments() async {
    return await _apiService.getAppointments();
  }

  // ==========================
  // Get Single Appointment
  // ==========================
  Future<AppointmentModel> getAppointmentById(
      String appointmentId) async {
    return await _apiService.getAppointmentById(
        appointmentId);
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
    return await _apiService.createAppointment(
      jobId: jobId,
      serviceProviderId: serviceProviderId,
      appointmentDate: appointmentDate,
      timeSlot: timeSlot,
      notes: notes,
    );
  }

  // ==========================
  // Update Appointment Status
  // ==========================
  Future<AppointmentModel> updateStatus({
    required String appointmentId,
    required String status,
  }) async {
    return await _apiService.updateStatus(
      appointmentId: appointmentId,
      status: status,
    );
  }

  // ==========================
  // Delete Appointment
  // ==========================
  Future<void> deleteAppointment(
      String appointmentId) async {
    await _apiService.deleteAppointment(appointmentId);
  }
}

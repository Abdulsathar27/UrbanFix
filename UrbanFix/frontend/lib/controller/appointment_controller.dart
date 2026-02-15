import 'package:flutter/material.dart';

import '../../data/models/appointment_model.dart';
import '../../data/repositories/appointment_repository.dart';

class AppointmentController extends ChangeNotifier {
  final AppointmentRepository _repository =
      AppointmentRepository();

  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ==========================
  // Getters
  // ==========================
  List<AppointmentModel> get appointments =>
      _appointments;

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
  // Fetch All Appointments
  // ==========================
  Future<void> fetchAppointments() async {
    try {
      _setLoading(true);
      _setError(null);

      final data = await _repository.getAppointments();
      _appointments = data;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Create Appointment
  // ==========================
  Future<void> createAppointment({
    required String jobId,
    required String serviceProviderId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final newAppointment =
          await _repository.createAppointment(
        jobId: jobId,
        serviceProviderId: serviceProviderId,
        appointmentDate: appointmentDate,
        timeSlot: timeSlot,
        notes: notes,
      );

      _appointments.add(newAppointment);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Update Status
  // ==========================
  Future<void> updateStatus({
    required String appointmentId,
    required String status,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedAppointment =
          await _repository.updateStatus(
        appointmentId: appointmentId,
        status: status,
      );

      final index = _appointments.indexWhere(
          (a) => a.id == appointmentId);

      if (index != -1) {
        _appointments[index] = updatedAppointment;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // ==========================
  // Delete Appointment
  // ==========================
  Future<void> deleteAppointment(
      String appointmentId) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repository.deleteAppointment(
          appointmentId);

      _appointments.removeWhere(
          (a) => a.id == appointmentId);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}

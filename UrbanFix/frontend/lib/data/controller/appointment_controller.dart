import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/data/services/appointment_api_service.dart';

class AppointmentController extends ChangeNotifier {
  AppointmentController({
    AppointmentApiService? appointmentApiService,
  }) : _appointmentApiService =
            appointmentApiService ?? AppointmentApiService();

  static const List<String> _defaultTimeSlots = <String>[
    '09:00 AM',
    '10:30 AM',
    '12:00 PM',
    '01:30 PM',
    '03:00 PM',
    '04:30 PM',
  ];
  static const Set<String> _disabledTimeSlots = <String>{
    '04:30 PM',
  };

  final AppointmentApiService _appointmentApiService;

  final List<AppointmentModel> _appointments = <AppointmentModel>[];
  bool _isLoading = false;
  String? _errorMessage;
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());
  String _selectedTimeSlot = _defaultTimeSlots.first;

  List<AppointmentModel> get appointments =>
      UnmodifiableListView<AppointmentModel>(_appointments);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  DateTime get selectedDate => _selectedDate;
  String get selectedTimeSlot => _selectedTimeSlot;
  List<String> get availableTimeSlots => _defaultTimeSlots;
  Set<String> get disabledTimeSlots => _disabledTimeSlots;

  List<DateTime> get availableDates => List<DateTime>.generate(
        14,
        (int index) => DateUtils.dateOnly(
          DateTime.now().add(Duration(days: index)),
        ),
      );

  double get estimatedTotal => 50;

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

  void selectDate(DateTime date) {
    final DateTime normalizedDate = DateUtils.dateOnly(date);
    if (DateUtils.isSameDay(_selectedDate, normalizedDate)) return;
    _selectedDate = normalizedDate;
    notifyListeners();
  }

  void selectTimeSlot(String timeSlot) {
    if (_disabledTimeSlots.contains(timeSlot)) return;
    if (_selectedTimeSlot == timeSlot) return;
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  Future<void> fetchAppointments() async {
    try {
      _setLoading(true);
      _setError(null);

      final List<AppointmentModel> fetchedAppointments =
          await _appointmentApiService.getAppointments();
      _appointments
        ..clear()
        ..addAll(fetchedAppointments);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> createAppointment({
    required String jobId,
    required String serviceProviderId,
    required DateTime appointmentDate,
    required String timeSlot,
    String? notes,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final AppointmentModel newAppointment =
          await _appointmentApiService.createAppointment(
        jobId: jobId,
        serviceProviderId: serviceProviderId,
        appointmentDate: appointmentDate,
        timeSlot: timeSlot,
        notes: notes,
      );

      _appointments.insert(0, newAppointment);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateStatus({
    required String appointmentId,
    required String status,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final AppointmentModel updatedAppointment =
          await _appointmentApiService.updateStatus(
        appointmentId: appointmentId,
        status: status,
      );

      final int index = _appointments.indexWhere(
        (AppointmentModel appointment) => appointment.id == appointmentId,
      );

      if (index != -1) {
        _appointments[index] = updatedAppointment;
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      _setLoading(true);
      _setError(null);

      await _appointmentApiService.deleteAppointment(appointmentId);

      _appointments.removeWhere(
        (AppointmentModel appointment) => appointment.id == appointmentId,
      );
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}

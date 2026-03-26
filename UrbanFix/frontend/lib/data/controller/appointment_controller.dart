import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/data/services/appointment_api_service.dart';
import 'package:intl/intl.dart';


class AppointmentController extends ChangeNotifier {
  final AppointmentApiService _appointmentApiService;

  final List<AppointmentModel> _sentAppointments = [];
  final List<AppointmentModel> _receivedAppointments = [];

  bool _isLoading = false;
  bool _isConfirming = false;
  String? _errorMessage;
  bool _isInitialized = false;

  String? _jobId;
  String? _workerId;
  String? _workTitle;
  double? _requestedWage;
  String? _description;
  String? _category;

  String _customerName = '';
  String _customerPhone = '';
  String _customerAddress = '';

  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());
  String _selectedTimeSlot = _defaultTimeSlots.first;

  static const List<String> _defaultTimeSlots = [
    '09:00 AM',
    '10:30 AM',
    '12:00 PM',
    '01:30 PM',
    '03:00 PM',
    '04:30 PM',
  ];
  Set<String> _disabledTimeSlots = {};

  AppointmentController({AppointmentApiService? appointmentApiService})
    : _appointmentApiService =
          appointmentApiService ?? AppointmentApiService() {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.wait([
      fetchSentAppointments(),
      fetchReceivedAppointments()
    ]);
    _isInitialized = true;
    notifyListeners();
  }

  String? get jobId => _jobId;
  String? get workerId => _workerId;
  String? get workTitle => _workTitle;
  double? get requestedWage => _requestedWage;
  String? get description => _description;
  String? get category => _category;

  String get customerName => _customerName;
  String get customerPhone => _customerPhone;
  String get customerAddress => _customerAddress;

  set customerName(String value) {
    _customerName = value;
    notifyListeners();
  }

  set customerPhone(String value) {
    _customerPhone = value;
    notifyListeners();
  }

  set customerAddress(String value) {
    _customerAddress = value;
    notifyListeners();
  }

  set category(String value) {
    _category = value;
    notifyListeners();
  }

  List<AppointmentModel> get sentAppointments =>
      UnmodifiableListView(_sentAppointments);
  List<AppointmentModel> get receivedAppointments =>
      UnmodifiableListView(_receivedAppointments);
  
  bool get isLoading => _isLoading;
  bool get isConfirming => _isConfirming;
  String? get errorMessage => _errorMessage;
  bool get isInitialized => _isInitialized;

  DateTime get selectedDate => _selectedDate;
  String get selectedTimeSlot => _selectedTimeSlot;
  List<String> get availableTimeSlots => _defaultTimeSlots;
  Set<String> get disabledTimeSlots => _disabledTimeSlots;

  List<DateTime> get availableDates => List.generate(
    14,
    (index) => DateUtils.dateOnly(DateTime.now().add(Duration(days: index))),
  );

  double get estimatedTotal => _requestedWage ?? 0.0;

  List<AppointmentModel> get upcomingAppointments {
    final now = DateTime.now();
    final allAppointments = [..._sentAppointments, ..._receivedAppointments];
    
    return allAppointments.where((appointment) {
      try {
        final appointmentDate = DateTime.parse(appointment.date);
        return appointment.status == 'pending' ||
            appointment.status == 'accepted' ||
            (appointment.status == 'confirmed' &&
                appointmentDate.isAfter(now.subtract(const Duration(days: 1))));
      } catch (e) {
        return false;
      }
    }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<AppointmentModel> get pastAppointments {
    final allAppointments = [..._sentAppointments, ..._receivedAppointments];
    
    return allAppointments.where((appointment) {
      return appointment.status == 'completed' ||
          appointment.status == 'cancelled' ||
          appointment.status == 'rejected';
    }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  int get upcomingCount => upcomingAppointments.length;

  
  String formatDate(String date) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat.yMMMd().format(parsed);
    } catch (e) {
      return date;
    }
  }

  String formatTime(String? time) {
    return time ?? 'TBD';
  }

  String formatStatus(String status) {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'accepted':
        return 'Accepted';
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'rejected':
        return 'Rejected';
      default:
        return status;
    }
  }

  String formatCurrency(double amount) {
    return '₹${amount.toStringAsFixed(2)}';
  }

  String getWorkerName(AppointmentModel appointment) {
    if (appointment.workerDetails != null &&
        appointment.workerDetails!['name'] != null) {
      return appointment.workerDetails!['name'];
    }
    return 'Service Provider';
  }

  String getCustomerName(AppointmentModel appointment) {
    if (appointment.userDetails != null &&
        appointment.userDetails!['name'] != null) {
      return appointment.userDetails!['name'];
    }
    return 'Customer';
  }

  void setServiceDetails({
    required String jobId,
    required String workerId,
    required String workTitle,
    required double requestedWage,
    String? description,
    String? category,
  }) {
    _jobId = jobId;
    _workerId = workerId;
    _workTitle = workTitle;
    _requestedWage = requestedWage;
    _description = description;
    
    if (category != null) {
      _category = category;
    }
    
    _fetchDisabledSlots(workerId);
    notifyListeners();
  }

  Future<void> _fetchDisabledSlots(String workerId) async {
    try {
      final slots = await _appointmentApiService.getWorkerAcceptedSlots(
        workerId,
      );
      _updateDisabledSlots(slots);
    } catch (e) {
      debugPrint('Failed to fetch disabled slots: $e');
    }
  }

  void _updateDisabledSlots(List<Map<String, String>> slots) {
    final selectedDateStr = _formatDate(_selectedDate);
    final disabled = <String>{};
    
    for (var slot in slots) {
      if (slot['date'] == selectedDateStr && slot['time'] != null) {
        disabled.add(slot['time']!);
      }
    }
    
    _disabledTimeSlots = disabled;
    
    if (_disabledTimeSlots.contains(_selectedTimeSlot)) {
      _selectedTimeSlot = _defaultTimeSlots.firstWhere(
        (slot) => !_disabledTimeSlots.contains(slot),
        orElse: () => _defaultTimeSlots.first,
      );
    }
    
    notifyListeners();
  }

  
  void selectDate(DateTime date) {
    final normalizedDate = DateUtils.dateOnly(date);
    if (DateUtils.isSameDay(_selectedDate, normalizedDate)) return;
    
    _selectedDate = normalizedDate;
    
    if (_workerId != null) {
      _fetchDisabledSlots(_workerId!);
    }
    
    notifyListeners();
  }

  void selectTimeSlot(String timeSlot) {
    if (_disabledTimeSlots.contains(timeSlot)) return;
    if (_selectedTimeSlot == timeSlot) return;
    
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }


  
  Future<bool> confirmAppointment(BuildContext context) async {
    clearError();

    if (_jobId == null ||
        _workerId == null ||
        _workTitle == null ||
        _requestedWage == null) {
      _setError(
        "Service details missing. Please go back and select a service.",
      );
      return false;
    }

   
    if (_customerName.trim().isEmpty) {
      _setError("Please enter your name");
      return false;
    }
    if (_customerPhone.trim().isEmpty) {
      _setError("Please enter your phone number");
      return false;
    }
    if (_customerAddress.trim().isEmpty) {
      _setError("Please enter your address");
      return false;
    }

    _isConfirming = true;
    notifyListeners();

    try {
      final appointment = AppointmentModel(
        id: '',
        userId: '',
        workerId: _workerId!,
        jobId: _jobId!,
        workTitle: _workTitle!,
        date: _formatDate(_selectedDate),
        time: _selectedTimeSlot,
        requestedWage: _requestedWage!,
        description: _description,
        status: 'pending',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final isCreated = await createAppointment(appointment);

      if (!context.mounted) return false;

      if (isCreated) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage ?? 'Failed to create appointment'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } finally {
      _isConfirming = false;
      notifyListeners();
    }
  }

  
  Future<bool> createAppointment(AppointmentModel appointment) async {
    try {
      _setLoading(true);
      _setError(null);

      // ✅ Call API to create appointment
      final newAppointment = await _appointmentApiService.createAppointment(
        appointment,
      );

      // ✅ Add to sent appointments list
      _sentAppointments.insert(0, newAppointment);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  
  Future<void> fetchSentAppointments() async {
    try {
      _setLoading(true);
      _setError(null);
      
      final appointments = await _appointmentApiService.getSentAppointments();
      _sentAppointments
        ..clear()
        ..addAll(appointments);
      
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchReceivedAppointments() async {
    try {
      _setLoading(true);
      _setError(null);
      
      final appointments = await _appointmentApiService.getReceivedAppointments();
      _receivedAppointments
        ..clear()
        ..addAll(appointments);
      
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshAppointments() async {
    await Future.wait([
      fetchSentAppointments(),
      fetchReceivedAppointments()
    ]);
  }

  
  Future<void> updateStatus({
    required AppointmentModel appointment,
    String? reason,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final updated = await _appointmentApiService.updateStatus(
        appointment,
        reason: reason,
      );
      
      _replaceInList(_sentAppointments, updated);
      _replaceInList(_receivedAppointments, updated);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> cancelAppointment({
    required String appointmentId,
    required String reason,
  }) async {
    try {
      _setLoading(true);
      _setError(null);
      
      await _appointmentApiService.cancelAppointment(
        appointmentId: appointmentId,
        reason: reason,
      );
      
      await refreshAppointments();
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
      
      _sentAppointments.removeWhere((a) => a.id == appointmentId);
      _receivedAppointments.removeWhere((a) => a.id == appointmentId);
      
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _replaceInList(List<AppointmentModel> list, AppointmentModel updated) {
    final index = list.indexWhere((a) => a.id == updated.id);
    if (index != -1) {
      list[index] = updated;
    }
  }

  
  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    _setError(null);
  }

  
  int _index = 0;
  int get index => _index;

  void select(int i) {
    if (_index == i) return;
    _index = i;
    notifyListeners();
  }

  bool _screenInitialized = false;

  Future<void> initialize() async {
    if (_screenInitialized) return;
    _screenInitialized = true;
    
    if (!isInitialized) {
      await refreshAppointments();
    }
  }

}
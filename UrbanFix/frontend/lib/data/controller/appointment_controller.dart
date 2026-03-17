import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:frontend/data/models/appointment_model.dart';
import 'package:frontend/data/services/appointment_api_service.dart';
import 'package:intl/intl.dart';

/// Appointment Controller
/// 
/// Manages appointment booking flow and appointment list management
/// State: Selected service details, date/time selection, appointments list
/// Methods: Create, fetch, update, cancel appointments
class AppointmentController extends ChangeNotifier {
  final AppointmentApiService _appointmentApiService;

  // ============================================================
  // LISTS
  // ============================================================
  final List<AppointmentModel> _sentAppointments = [];
  final List<AppointmentModel> _receivedAppointments = [];

  // ============================================================
  // STATE
  // ============================================================
  bool _isLoading = false;
  bool _isConfirming = false;
  String? _errorMessage;
  bool _isInitialized = false;

  // ============================================================
  // SELECTED SERVICE DETAILS (from booking flow)
  // ============================================================
  String? _jobId;
  String? _workerId;
  String? _workTitle;
  double? _requestedWage;
  String? _description;
  String? _category;

  // ============================================================
  // CUSTOMER DETAILS (from location section)
  // ============================================================
  String _customerName = '';
  String _customerPhone = '';
  String _customerAddress = '';

  // ============================================================
  // DATE/TIME SELECTION
  // ============================================================
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());
  String _selectedTimeSlot = _defaultTimeSlots.first;

  // Time slots (7 AM - 8 PM as per backend validation)
  static const List<String> _defaultTimeSlots = [
    '09:00 AM',
    '10:30 AM',
    '12:00 PM',
    '01:30 PM',
    '03:00 PM',
    '04:30 PM',
  ];
  Set<String> _disabledTimeSlots = {};

  // ============================================================
  // CONSTRUCTOR WITH DEPENDENCY INJECTION
  // ============================================================
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

  // ============================================================
  // PUBLIC GETTERS - SERVICE & CUSTOMER DETAILS
  // ============================================================
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

  // ============================================================
  // PUBLIC GETTERS - APPOINTMENTS & STATE
  // ============================================================
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

  // ============================================================
  // FILTERED LISTS
  // ============================================================
  
  /// Upcoming appointments (pending, accepted, confirmed)
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

  /// Past appointments (completed, cancelled, rejected)
  List<AppointmentModel> get pastAppointments {
    final allAppointments = [..._sentAppointments, ..._receivedAppointments];
    
    return allAppointments.where((appointment) {
      return appointment.status == 'completed' ||
          appointment.status == 'cancelled' ||
          appointment.status == 'rejected';
    }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Upcoming appointment count for profile card
  int get upcomingCount => upcomingAppointments.length;

  // ============================================================
  // FORMATTING HELPERS
  // ============================================================
  
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

  // ============================================================
  // CORE LOGIC: Set Service Details
  // ============================================================
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
    
    // ✅ Only set category if provided (don't overwrite with null)
    if (category != null) {
      _category = category;
    }
    
    // ✅ Fetch disabled time slots for this worker
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
    
    // ✅ Add slots that are booked for this date
    for (var slot in slots) {
      if (slot['date'] == selectedDateStr && slot['time'] != null) {
        disabled.add(slot['time']!);
      }
    }
    
    _disabledTimeSlots = disabled;
    
    // ✅ If selected slot is now disabled, pick first available
    if (_disabledTimeSlots.contains(_selectedTimeSlot)) {
      _selectedTimeSlot = _defaultTimeSlots.firstWhere(
        (slot) => !_disabledTimeSlots.contains(slot),
        orElse: () => _defaultTimeSlots.first,
      );
    }
    
    notifyListeners();
  }

  // ============================================================
  // CORE LOGIC: Date/Time Selection
  // ============================================================
  
  void selectDate(DateTime date) {
    final normalizedDate = DateUtils.dateOnly(date);
    if (DateUtils.isSameDay(_selectedDate, normalizedDate)) return;
    
    _selectedDate = normalizedDate;
    
    // ✅ Fetch new disabled slots for this date
    if (_workerId != null) {
      _fetchDisabledSlots(_workerId!);
    }
    
    notifyListeners();
  }

  void selectTimeSlot(String timeSlot) {
    // ✅ Don't allow selecting disabled slots
    if (_disabledTimeSlots.contains(timeSlot)) return;
    if (_selectedTimeSlot == timeSlot) return;
    
    _selectedTimeSlot = timeSlot;
    notifyListeners();
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // ============================================================
  // CORE LOGIC: Confirm Appointment
  // ============================================================
  
  Future<bool> confirmAppointment(BuildContext context) async {
    clearError();

    // ✅ Validate all required fields
    if (_jobId == null ||
        _workerId == null ||
        _workTitle == null ||
        _requestedWage == null) {
      _setError(
        "Service details missing. Please go back and select a service.",
      );
      return false;
    }

    // ✅ Validate customer details
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
      // NOTE: 'id' and 'userId' are intentionally empty here.
      // The API service sends only the required fields (worker, job, workTitle,
      // date, time, requestedWage, description). The backend sets 'user'
      // automatically from the JWT token — never send it from the client.
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
      // Always reset — even if context.mounted was false or an error was thrown
      _isConfirming = false;
      notifyListeners();
    }
  }

  // ============================================================
  // CORE LOGIC: Create Appointment
  // ============================================================
  
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

  // ============================================================
  // CORE LOGIC: Fetch Appointments
  // ============================================================
  
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

  // ============================================================
  // CORE LOGIC: Update/Cancel Appointments
  // ============================================================
  
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

  // ============================================================
  // PRIVATE HELPERS
  // ============================================================
  
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

  // ============================================================
  // TAB MANAGEMENT (for appointments screen)
  // ============================================================
  
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

  // ============================================================
  // CLEANUP
  // ============================================================
  
  @override
  void dispose() {
    super.dispose();
  }


}
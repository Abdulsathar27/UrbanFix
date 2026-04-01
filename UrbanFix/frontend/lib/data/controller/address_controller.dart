import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/address_model.dart';

class AddressController extends ChangeNotifier {
  static const String _storageKey = 'saved_addresses';

  List<AddressModel> _addresses = [];
  bool _isLoading = false;

  List<AddressModel> get addresses => List.unmodifiable(_addresses);
  bool get isLoading => _isLoading;

  final TextEditingController addressTextController = TextEditingController();
  String selectedLabel = 'Home';

  static const List<String> labels = ['Home', 'Work', 'Other'];

  AddressController() {
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      final List decoded = jsonDecode(raw) as List;
      _addresses = decoded
          .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addAddress() async {
    final text = addressTextController.text.trim();
    if (text.isEmpty) return false;

    final newAddress = AddressModel.create(
      label: selectedLabel,
      address: text,
    );

    _addresses.add(newAddress);
    await _persist();
    addressTextController.clear();
    selectedLabel = 'Home';
    notifyListeners();
    return true;
  }

  Future<void> deleteAddress(String id) async {
    _addresses.removeWhere((a) => a.id == id);
    await _persist();
    notifyListeners();
  }

  void setLabel(String label) {
    selectedLabel = label;
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(_addresses.map((a) => a.toJson()).toList()),
    );
  }

  @override
  void dispose() {
    addressTextController.dispose();
    super.dispose();
  }
}

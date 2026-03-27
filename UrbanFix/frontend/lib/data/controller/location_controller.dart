import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends ChangeNotifier {
  String _locationLabel = 'Locating...';
  bool _isLoading = false;
  String? _errorMessage;

  String get locationLabel => _locationLabel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LocationController() {
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationLabel = 'Location Off';
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _locationLabel = 'No Permission';
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        _locationLabel =
            place.subLocality?.isNotEmpty == true
                ? place.subLocality!
                : place.locality?.isNotEmpty == true
                ? place.locality!
                : place.administrativeArea ?? 'Unknown';
      } else {
        _locationLabel = 'Unknown';
      }
    } catch (e) {
      _locationLabel = 'Unavailable';
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

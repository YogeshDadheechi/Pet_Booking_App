import 'package:flutter/foundation.dart';
import '../models/pet_service.dart';
import '../models/booking.dart';
import '../services/api_service.dart';

enum ServiceStatus { initial, loading, loaded, error }

class ServiceProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  ServiceStatus _status = ServiceStatus.initial;
  List<PetService> _services = [];
  String _errorMessage = '';
  List<Booking> _bookings = [];
  double _walletBalance = 2000.0;

  ServiceStatus get status => _status;
  List<PetService> get services => _services;
  String get errorMessage => _errorMessage;
  List<Booking> get bookings => _bookings;
  double get walletBalance => _walletBalance;

  Future<void> fetchServices() async {
    _status = ServiceStatus.loading;
    notifyListeners();

    try {
      _services = await _apiService.fetchServices();
      _status = ServiceStatus.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _status = ServiceStatus.error;
    }

    notifyListeners();
  }

  void addBooking(Booking booking) {
    _bookings.insert(0, booking);
    _walletBalance -= booking.price;
    notifyListeners();
  }

  void retryFetch() => fetchServices();
}

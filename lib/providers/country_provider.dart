import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';

class CountryProvider extends ChangeNotifier {
  final ApiService _api = ApiService();

  List<Country> _countries = [];
  bool _isLoading = false;
  String? _error;

  List<Country> get countries => _countries;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCountries() async {
    _isLoading = true;        // Loading state (DH-04)
    _error = null;
    notifyListeners();

    try {
      _countries = await _api.fetchCountries();
    } catch (e) {
      _error = e.toString();  // Error handling (DH-03)
      _countries = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // BONUS: simple search en mémoire
  List<Country> search(String query) {
    if (query.isEmpty) return _countries;
    final q = query.toLowerCase();
    return _countries.where((c) => c.name.toLowerCase().contains(q)).toList();
  }
}

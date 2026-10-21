import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airbnb_clone/models/home.dart';
import 'package:airbnb_clone/util/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WishlistProvider extends ChangeNotifier {
  List<Home> _wishlist = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Home> get wishlist => _wishlist;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  bool isWishlisted(Home home) {
    return home.id != null && _wishlist.any((item) => item.id == home.id);
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      return token;
    }

    const storage = FlutterSecureStorage();
    return await storage.read(key: 'jwt_token');
  }

  Future<void> fetchWishlist() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final token = await _getToken();

      if (token == null || token.isEmpty) {
        _wishlist = [];
        _errorMessage = 'Please log in to view your wishlist.';
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/wishlist'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _wishlist = (data['wishlist'] as List)
            .map((item) => Home.fromJson(item))
            .toList();
      } else {
        _errorMessage = response.statusCode == 401
            ? 'Session expired. Please log in again.'
            : 'Failed to fetch wishlist.';
      }
    } catch (error) {
      _errorMessage = 'Could not connect to server.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleWishlist(Home home) async {
    if (home.id == null) {
      _errorMessage = 'This home has no valid ID.';
      notifyListeners();
      return false;
    }

    final token = await _getToken();

    if (token == null || token.isEmpty) {
      _errorMessage = 'Please log in to save homes.';
      notifyListeners();
      return false;
    }

    final wasSaved = isWishlisted(home);
    final uri = Uri.parse('$baseUrl/api/wishlist/${home.id}');
    try {
      final response = wasSaved
          ? await http.delete(uri, headers: {'Authorization': 'Bearer $token'})
          : await http.post(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _wishlist = (data['wishlist'] as List)
            .map((item) => Home.fromJson(item))
            .toList();

        _errorMessage = '';
        notifyListeners();
        return true;
      }

      _errorMessage = response.statusCode == 401
          ? 'Session expired. Please log in again.'
          : 'Failed to update wishlist.';
      notifyListeners();
      return false;
    } catch (error) {
      _errorMessage = 'Could not connect to server.';
      notifyListeners();
      return false;
    }
  }

  void clearWishlist() {
    _wishlist = [];
    _errorMessage = '';
    notifyListeners();
  }
}

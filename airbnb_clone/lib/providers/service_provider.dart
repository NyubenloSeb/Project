import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:airbnb_clone/models/service.dart';
import 'package:http/http.dart' as http;
import 'package:airbnb_clone/util/constants.dart';

class ServiceProvider extends ChangeNotifier {
  //state variables
  List<Service> _services = [];
  bool _isLoading = false;
  String _errorMessage = '';

  //public getters
  List<Service> get services => _services;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  //add auth token later when adding login system

  Future<void> fetchService() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/v1/get/service'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final List<dynamic> homesJson = data['response'];
        _services = homesJson.map((json) => Service.fromJson(json)).toList();
      } else {
        _errorMessage = "Failed to fetch data: ${response.statusCode}";
      }
    } catch (error) {
      _errorMessage = "Error connecting to server: $error";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

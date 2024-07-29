import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mitra_app/features/presentation/monitoring_mitra/models/quis_pertanyaan_model.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/services/apiservices.dart';

class QuisPertanyaanProvider with ChangeNotifier {
  List<QuisPertanyaan> _quisPertanyaanList = [];
  bool _isLoading = false;

  List<QuisPertanyaan> get quisPertanyaanList => _quisPertanyaanList;
  bool get isLoading => _isLoading;

  Future<void> fetchQuisPertanyaan(int idMitra) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await QuisPertanyaanService().getQuisPertanyaan(idMitra);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic>? data = responseBody['data'];

      if (data != null) {
        _quisPertanyaanList =
            data.map((item) => QuisPertanyaan.fromJson(item)).toList();
      } else {
        _quisPertanyaanList = [];
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load quis data: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

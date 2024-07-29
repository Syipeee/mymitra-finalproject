import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mitra_app/features/presentation/monitoring_mitra/models/quis_jawaban_pilihan_model.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/services/apiservices.dart';

class QuisJawabanPilihanProvider with ChangeNotifier {
  List<QuisJawabanPilihan> _quisJawabanPilihanList = [];
  bool _isLoading = false;

  List<QuisJawabanPilihan> get quisJawabanPilihanList =>
      _quisJawabanPilihanList;
  bool get isLoading => _isLoading;

  Future<void> fetchQuisJawabanPilihan(int idMitra) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await QuisJawabanPilihanService().getQuisJawabanPilihan(idMitra);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic>? data = responseBody['data'];

      if (data != null) {
        _quisJawabanPilihanList =
            data.map((item) => QuisJawabanPilihan.fromJson(item)).toList();
      } else {
        _quisJawabanPilihanList = [];
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

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mitra_app/features/presentation/monitoring_mitra/services/apiservices.dart';

class QuisJawabanVMitraProvider with ChangeNotifier {
  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  Future<void> insertQuisJawabanVMitra(
    String pendaftar,
    String quisPertanyaan,
    String quisJawabanPilihan,
    String jawabanIsian,
  ) async {
    _isSubmitting = true;
    notifyListeners();

    try {
      final response = await QuisJawabanVMitraService().insertQuisJawabanVMitra(
        pendaftar,
        quisPertanyaan,
        quisJawabanPilihan,
        jawabanIsian,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to insert quis jawaban');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}

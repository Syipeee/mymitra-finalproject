// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_vassessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/read_vassessment_response.dart';

import 'package:provider/provider.dart' as provider;

class VReadAssessmentProviders extends ChangeNotifier {
  final GetVReadAssessment getVReadAssessment;
  List<VReadAssessmentData>? _readVAssessments;
  final String idMitra;
  late String idMahasiswa;

  String userNomor = '0';

  VReadAssessmentProviders({
    required this.getVReadAssessment,
    required this.idMitra,
  });

  List<VReadAssessmentData>? get readVAssessments => _readVAssessments;

  Future<void> getVReadAssessmentData() async {
    try {
      final result = await getVReadAssessment.execute(
        idMitra: idMitra,
        idMahasiswa: idMahasiswa,
      );

      // Setelah mendapatkan hasil, perbarui _readVAssessments
      result.sort((a, b) => b.nomor.compareTo(a.nomor));

      _readVAssessments = result;
      if (result.isNotEmpty) {
        setCurrentSessionUser(result.first);
        print('test${result}');
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void setCurrentSessionUser(VReadAssessmentData? user) {
    if (user == null) {
      return;
    }
    userNomor = user.mahasiswa;
    notifyListeners();
  }

  static VReadAssessmentProviders of(BuildContext context,
      {required bool listen}) {
    return provider.Provider.of<VReadAssessmentProviders>(context,
        listen: listen);
  }
}

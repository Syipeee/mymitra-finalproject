import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_kategori_assessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/kategori_assessment_response.dart';

import 'package:provider/provider.dart' as provider;

class KategoriAssessmentProviders extends ChangeNotifier {
  final GetKategoriAssessment getKategoriAssessment;
  List<KategoriAssessment>? _kategoriAssessments;

  KategoriAssessmentProviders({required this.getKategoriAssessment});

  List<KategoriAssessment>? get kategoriAssessments => _kategoriAssessments;

  Future<void> getKategoriAssessmentData() async {
    try {
      final result = await getKategoriAssessment.execute();
      _kategoriAssessments = result;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  static KategoriAssessmentProviders of(BuildContext context,
      {required bool listen}) {
    return provider.Provider.of<KategoriAssessmentProviders>(context,
        listen: listen);
  }
}

import 'dart:ui';

import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/delete_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/delete_assessment_response.dart';

class DeleteAssessment {
  final DeleteAssessmentRepository repository;

  DeleteAssessment(this.repository);

  Future<void> deleteAssessment({
    VoidCallback? onSuccess,
    VoidCallback? onError,
    required String nomor,
  }) async {
    try {
      final DeleteAssessmentResponse response =
          await repository.deleteAssessment(
        nomor: nomor,
      );
      print('test :' + nomor);
      // Menambahkan pengecekan status response
      if (response.status == 'sukses') {
        onSuccess?.call();
      } else {
        onError?.call();
      }
    } catch (e) {
      print('Error in DeleteAssessment: $e');
      rethrow;
    }
  }
}

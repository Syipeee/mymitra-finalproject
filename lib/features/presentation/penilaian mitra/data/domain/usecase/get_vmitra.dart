import 'dart:ui';

import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/vmitra_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vmitra_response.dart';

class GetVmitra {
  final VmitraRepository repository;

  GetVmitra(this.repository);

  Future<Vmitra> execute({
    VoidCallback? onSuccess,
    VoidCallback? onError,
    required String username,
    required String password,
  }) async {
    try {
      final result = await repository.getVmitra(
        username: username,
        password: password,
      );
      return result;
    } catch (e) {
      print('Error in postInsertNilaiAssessmentData: $e');
      rethrow;
    }
  }
}

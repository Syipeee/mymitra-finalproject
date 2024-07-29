import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/read_vassessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/read_vassessment_response.dart';

class GetVReadAssessment {
  final VReadAssessmentRepository repository;

  GetVReadAssessment(this.repository);
  Future<List<VReadAssessmentData>> execute({
    required String idMitra,
    required String idMahasiswa,
  }) async {
    final result = await repository.getVReadAssessment(
      idMitra: idMitra,
      idMahasiswa: idMahasiswa,
    );
    return result;
  }
}

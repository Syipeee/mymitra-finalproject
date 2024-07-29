import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/kategori_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/kategori_assessment_response.dart';

class GetKategoriAssessment {
  final KategoriAssessmentRepository repository;

  GetKategoriAssessment(this.repository);
  Future<List<KategoriAssessment>> execute({
    String? page,
  }) async {
    final result = await repository.getKategoriAssessment();
    return result;
  }
}

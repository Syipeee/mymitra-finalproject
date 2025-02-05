import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/kategori_assessment_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/kategori_assessment_response.dart';

abstract class KategoriAssessmentRepository {
  Future<List<KategoriAssessment>> getKategoriAssessment();
}

class KategoriAssessmentRepositoryImpl implements KategoriAssessmentRepository {
  final KategoriAssessmentRemoteDataSource remoteDataSource;

  KategoriAssessmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<KategoriAssessment>> getKategoriAssessment() async {
    try {
      final response = await remoteDataSource.getKategoriAssessment();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

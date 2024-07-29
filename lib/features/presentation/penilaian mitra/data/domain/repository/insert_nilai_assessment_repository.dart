import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/insert_assessment_remote_datasource.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/insert_assessment_response.dart';

abstract class InsertAssessmentRepository {
  Future<List<AssessmentData>> postInsertNilaiAssessment({
    String? kategoriAssessment,
    String? pendaftar,
    required String nilai,
    String? vmitra,
  });
}

class InsertNilaiAssessmentRepositoryImpl
    implements InsertAssessmentRepository {
  final InsertAssessmentRemoteDataSource remoteDataSource;

  InsertNilaiAssessmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AssessmentData>> postInsertNilaiAssessment({
    String? kategoriAssessment,
    String? pendaftar,
    required String nilai,
    String? vmitra,
  }) async {
    try {
      final response = await remoteDataSource.postInsertNilaiAssessment(
        kategoriAssessment: kategoriAssessment,
        pendaftar: pendaftar,
        nilai: nilai,
        vmitra: vmitra,
      );
      return response;
    } catch (e) {
      print('Error in postInsertNilaiAssessment: $e');
      rethrow;
    }
  }
}

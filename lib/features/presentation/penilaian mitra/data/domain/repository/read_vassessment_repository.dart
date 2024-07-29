import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/read_vassessment_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/read_vassessment_response.dart';

abstract class VReadAssessmentRepository {
  Future<List<VReadAssessmentData>> getVReadAssessment({
    required String idMitra,
    required String idMahasiswa,
  });
}

class VReadAssessmentRepositoryImpl implements VReadAssessmentRepository {
  final VReadAssessmentRemoteDataSource remoteDataSource;

  VReadAssessmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<VReadAssessmentData>> getVReadAssessment({
    required String idMitra,
    required String idMahasiswa,
  }) async {
    try {
      final response = await remoteDataSource.getVReadAssessment(
        idMitra: idMitra,
        idMahasiswa: idMahasiswa,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

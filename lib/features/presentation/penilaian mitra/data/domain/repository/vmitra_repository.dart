import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/vmitra_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vmitra_response.dart';

abstract class VmitraRepository {
  Future<Vmitra> getVmitra({
    required String username,
    required String password,
  });
}

class VmitraRepositoryImpl implements VmitraRepository {
  final VmitraRemoteDataSource remoteDataSource;

  VmitraRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Vmitra> getVmitra({
    required String username,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.getVmitra(
        username: username,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

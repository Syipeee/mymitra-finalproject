import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/vpendaftar_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';

abstract class VpendaftarRepository {
  Future<List<VPendaftar>> getVpendaftar({required String idMitra});
}

class VpendaftarRepositoryImpl implements VpendaftarRepository {
  final VpendaftarRemoteDataSource remoteDataSource;

  VpendaftarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<VPendaftar>> getVpendaftar({required String idMitra}) async {
    try {
      final response = await remoteDataSource.getVpendaftar(
        idMitra: idMitra,
      );
      // print("belly1$response");
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

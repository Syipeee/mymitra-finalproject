import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/vpendaftar_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';

class GetVpendaftar {
  final VpendaftarRepository repository;

  GetVpendaftar(this.repository);
  Future<List<VPendaftar>> execute({
    required String idMitra,
  }) async {
    final result = await repository.getVpendaftar(
      idMitra: idMitra,
    );
    // print("belly2$result");
    return result;
  }
}

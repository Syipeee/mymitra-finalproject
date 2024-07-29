import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_vpendaftar.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';
import 'package:provider/provider.dart' as provider;

class VpendaftarProviders extends ChangeNotifier {
  final GetVpendaftar getVpendaftar;
  List<VPendaftar>? _vpendaftars;
  late String idMitra;

  VpendaftarProviders({
    required this.getVpendaftar,
    required this.idMitra,
  });

  List<VPendaftar>? get vpendaftars => _vpendaftars;

  Future<void> getVpendaftarData() async {
    try {
      final result = await getVpendaftar.execute(
        idMitra: idMitra,
      );

      _vpendaftars = result;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  static VpendaftarProviders of(BuildContext context, {required bool listen}) {
    return provider.Provider.of<VpendaftarProviders>(context, listen: listen);
  }
}

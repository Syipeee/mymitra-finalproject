import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/models/logbook_pendaftar_dokumen_model.dart';
import 'dart:convert';
import 'package:mitra_app/features/presentation/monitoring_mitra/services/apiservices.dart';

class LogbookPendaftarDokumenProvider extends ChangeNotifier {
  final LogbookPendaftarDokumenServices _services =
      LogbookPendaftarDokumenServices();
  List<LogbookPendaftarDokumen> _logbooks = [];

  List<LogbookPendaftarDokumen> get logbooks => _logbooks;

  Future<void> fetchLogbookPendaftarDokumen(
      int idMitra, String logbookPendaftar) async {
    final response =
        await _services.getLogbookPendaftarDokumen(idMitra, logbookPendaftar);
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      if (data is List) {
        _logbooks =
            data.map((item) => LogbookPendaftarDokumen.fromJson(item)).toList();
      } else {
        _logbooks = [];
      }
      notifyListeners();
    }
  }

  List<LogbookPendaftarDokumen> getLogbookDokumenByNomor(String nomor) {
    try {
      return _logbooks
          .where((logbook) => logbook.logbookPendaftar == nomor)
          .toList();
    } catch (e) {
      return [];
    }
  }
}

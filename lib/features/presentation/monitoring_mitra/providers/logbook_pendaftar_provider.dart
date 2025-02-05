import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/models/pendaftar_model.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/services/apiservices.dart';

class LogbookPendaftarMonitoringProvider extends ChangeNotifier {
  List<LogbookPendaftarMonitoring> _logbookPendaftar = [];
  bool _isLoading = false;

  List<LogbookPendaftarMonitoring> get logbookPendaftar => _logbookPendaftar;
  bool get isLoading => _isLoading;

  Future<void> fetchLogbookPendaftar(int idMitra) async {
    _isLoading = true;
    notifyListeners();

    LogbookPendaftarServices service = LogbookPendaftarServices();
    try {
      final response = await service.getLogbookPendaftar(idMitra);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Data from API: $data'); // Tambahkan print statement
        var logbookList = (data['data'] as List)
            .map((item) => LogbookPendaftarMonitoring.fromJson(item))
            .toList();
        _logbookPendaftar = logbookList;
      } else {
        throw Exception('Failed to load logbook data');
      }
    } catch (e) {
      print('Error fetching logbook data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  LogbookPendaftarMonitoring? getLogbookByDate(
      String date, String idPendaftar) {
    try {
      print(
          'Looking for logbook with date: $date and idPendaftar: $idPendaftar'); // Tambahkan print statement
      DateTime parsedDate = DateFormat('dd MMM yyyy').parse(date);
      String formattedDate =
          DateFormat('dd-MMM-yy').format(parsedDate).toUpperCase();
      print('Formatted Date: $formattedDate'); // Tambahkan print statement

      var logbook = _logbookPendaftar.firstWhere(
        (log) => log.tanggal == formattedDate && log.pendaftar == idPendaftar,
        orElse: () => LogbookPendaftarMonitoring(
          nomor: '',
          pendaftar: '',
          tanggal: '',
          namaKegiatan: '',
          latitude: '',
          longitude: '',
        ),
      );
      print('Found logbook: $logbook'); // Tambahkan print statement
      return logbook;
    } catch (e) {
      print('Error finding logbook by date: $e');
      return null;
    }
  }
}

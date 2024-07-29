import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mitra_app/common/url.dart';

class LogbookPendaftarServices {
  Future<Response> getLogbookPendaftar(int idMitra) async {
    final requestBody = {
      "table": "logbook_pendaftar",
      "data": ["*"]
    };
    final headers = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    return post(
      Uri.parse("${dynamicAPIUrl}read_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: headers,
    );
  }
}

class LogbookPendaftarDokumenServices {
  Future<http.Response> getLogbookPendaftarDokumen(
      int idMitra, String logbookPendaftar) async {
    final requestBody = {
      "table": "logbook_pendaftar_dokumen",
      "data": ["*"],
      "filter": {
        "LOGBOOK_PENDAFTAR": logbookPendaftar,
      }
    };
    final headers = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await http.post(
      Uri.parse("${dynamicAPIUrl}read_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load logbook data');
    }
  }
}

class LogbookMonitoringServices {
  Future<Response> insertLogbookMonitoring(
    String pendaftar,
    String tanggalAwal,
    String tanggalAkhir,
    String catatan,
    String approval,
    String vmitra,
  ) async {
    final requestBody = {
      "table": "logbook_monitoring",
      "data": [
        {
          "PENDAFTAR": pendaftar,
          "TANGGAL_AWAL": tanggalAwal,
          "TANGGAL_AKHIR": tanggalAkhir,
          "CATATAN": catatan,
          "APPROVAL": approval,
          "VMITRA": vmitra,
        }
      ]
    };
    final headers = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await post(
      Uri.parse("${dynamicAPIUrl}insert_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    print('Request Body: ${jsonEncode(requestBody)}');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    return response;
  }
}

class QuisPertanyaanService {
  Future<http.Response> getQuisPertanyaan(int idMitra) async {
    final requestBody = {
      "table": "quis_pertanyaan",
      "data": ["*"],
      "filter": {
        "quis_jenis": "1",
      }
    };
    final headers = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await http.post(
      Uri.parse("${dynamicAPIUrl}read_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load logbook data');
    }
  }
}

class QuisJawabanPilihanService {
  Future<http.Response> getQuisJawabanPilihan(int idMitra) async {
    final requestBody = {
      "table": "quis_jawaban_pilihan",
      "data": ["*"]
    };
    final headers = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await http.post(
      Uri.parse("${dynamicAPIUrl}read_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load logbook data');
    }
  }
}

class QuisJawabanVMitraService {
  Future<Response> insertQuisJawabanVMitra(
    String pendaftar,
    String quisPertanyaan,
    String quisJawabanPilihan,
    String jawabanIsian,
  ) async {
    final requestBody = {
      "table": "quis_jawaban_vmitra",
      "data": [
        {
          "PENDAFTAR": pendaftar,
          "QUIS_PERTANYAAN": quisPertanyaan,
          "QUIS_JAWABAN_PILIHAN": quisJawabanPilihan,
          "JAWABAN_ISIAN": jawabanIsian,
        }
      ]
    };
    final headers = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await post(
      Uri.parse("${dynamicAPIUrl}insert_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    print('Request Body: ${jsonEncode(requestBody)}');
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    return response;
  }
}

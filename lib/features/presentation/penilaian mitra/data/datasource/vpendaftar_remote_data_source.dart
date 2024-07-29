import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';
import 'package:mitra_app/common/url.dart';

abstract class VpendaftarRemoteDataSource {
  Future<List<VPendaftar>> getVpendaftar({
    required String idMitra,
  });
}

class VpendaftarRemoteDataSourceImpl implements VpendaftarRemoteDataSource {
  @override
  Future<List<VPendaftar>> getVpendaftar({
    required String idMitra,
  }) async {
    final requestBody = {
      "table": "vpendaftar",
      "data": ["*"],
      "filter": {
        "VMITRA": idMitra,
      }
    };
    final header = {
      "x-api-key": apiKey,
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final response = await post(
      Uri.parse("${dynamicAPIUrl}read_pendaftaran_mbkm"),
      body: jsonEncode(requestBody),
      headers: header,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('JSON Response: $jsonResponse');
      final List<dynamic> responseData = jsonResponse['data'];
      // print('Response Data: $responseData');
      return responseData.map((json) => VPendaftar.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load VPendaftar ');
    }
  }
}

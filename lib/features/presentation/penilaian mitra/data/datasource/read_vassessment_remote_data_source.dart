import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/read_vassessment_response.dart';
import 'package:mitra_app/common/url.dart';

abstract class VReadAssessmentRemoteDataSource {
  Future<List<VReadAssessmentData>> getVReadAssessment({
    required String idMitra,
    required String idMahasiswa,
  });
}

class VReadNilaiAssessmentRemoteDataSourceImpl
    implements VReadAssessmentRemoteDataSource {
  @override
  Future<List<VReadAssessmentData>> getVReadAssessment({
    required String idMitra,
    required String idMahasiswa,
  }) async {
    final requestBody = {
      "table": "vnilai_assesment",
      "data": ["*"],
      "filter": {
        "VMITRA": idMitra,
        "MAHASISWA": idMahasiswa,
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
      print('readvassessment BELLY: $jsonResponse');
      final List<dynamic> responseData = jsonResponse['data'];
      // print('readvassessment: $responseData');
      return responseData
          .map((json) => VReadAssessmentData.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Kategori assessment');
    }
  }
}

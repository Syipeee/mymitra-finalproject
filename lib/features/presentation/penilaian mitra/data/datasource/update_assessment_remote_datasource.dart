// update_assessment_remote_datasource.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/update_assessment_response.dart';
import 'package:mitra_app/common/url.dart';

abstract class UpdateAssessmentRemoteDataSource {
  Future<AssessmentResponseUpdate> updateAssessmentData({
    required String nilai,
    required String nomor,
    required String tanggal,
  });
}

class UpdateAssessmentRemoteDataSourceImpl
    implements UpdateAssessmentRemoteDataSource {
  @override
  Future<AssessmentResponseUpdate> updateAssessmentData({
    required String nilai,
    required String nomor,
    required String tanggal,
  }) async {
    try {
      final jsonData = {
        "table": "nilai_assesment",
        "data": {
          "NILAI": nilai,
          "TANGGAL": {
            "value": tanggal,
            "type": "date",
          },
        },
        "conditions": {"NOMOR": nomor}
      };

      // print(jsonData);

      final header = {
        "x-api-key": apiKey,
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      final response = await post(
        Uri.parse("${dynamicAPIUrl}update_pendaftaran_mbkm"),
        body: jsonEncode(jsonData),
        headers: header,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Respon JSON: $jsonResponse');
        // return jsonResponse;
        return AssessmentResponseUpdate.fromJson(jsonResponse);
      } else {
        throw Exception('Gagal update nilai assessment');
      }
    } catch (e) {
      print('Error in updateAssessmentData: $e');
      rethrow;
    }
  }
}

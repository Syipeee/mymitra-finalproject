// update_assessment_remote_datasource.dart

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/delete_assessment_response.dart';
import 'package:mitra_app/common/url.dart';

abstract class DeleteAssessmentRemoteDataSource {
  Future<DeleteAssessmentResponse> deleteAssessmentData({
    required String nomor,
  });
}

class DeleteAssessmentRemoteDataSourceImpl
    implements DeleteAssessmentRemoteDataSource {
  @override
  Future<DeleteAssessmentResponse> deleteAssessmentData({
    required String nomor,
  }) async {
    try {
      final jsonData = {
        "table": "nilai_assesment",
        "conditions": {
          "NOMOR": nomor,
        }
      };

      print(jsonData);

      final header = {
        "x-api-key": apiKey,
        HttpHeaders.contentTypeHeader: 'application/json'
      };

      final response = await post(
        Uri.parse("${dynamicAPIUrl}delete_pendaftaran_mbkm"),
        body: jsonEncode(jsonData),
        headers: header,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Respon JSON: $jsonResponse');

        // return jsonResponse;
        return DeleteAssessmentResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Gagal Delete nilai assessment');
      }
    } catch (e) {
      print('Error in DeleteAssessmentData: $e');
      rethrow;
    }
  }
}

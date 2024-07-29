import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vmitra_response.dart';
import 'package:mitra_app/common/url.dart';

abstract class VmitraRemoteDataSource {
  Future<Vmitra> getVmitra({
    required String username,
    required String password,
  });
}

class VmitraRemoteDataSourceImpl implements VmitraRemoteDataSource {
  @override
  Future<Vmitra> getVmitra({
    required String username,
    required String password,
  }) async {
    final requestBody = {
      "table": "vmitra",
      "data": ["*"],
      "filter": {
        "USERNAME": username,
        "PASSWORD": password,
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
      return responseData.map((json) => Vmitra.fromJson(json)).toList().single;
    } else {
      throw Exception('Failed to load Vmitra ');
    }
  }
}

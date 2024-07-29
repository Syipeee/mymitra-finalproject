// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_vmitra.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vmitra_response.dart';

class VmitraProviders extends ChangeNotifier {
  final GetVmitra getVmitra;

  String userNomor = '0';
  VmitraProviders({required this.getVmitra});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> getVmitraData({
    VoidCallback? onSuccess,
    VoidCallback? onError,
    required String username,
    required String password,
  }) async {
    try {
      final result = await getVmitra.execute(
        username: username,
        password: password,
      );
      // _vMitra = result;

      setCurrentSessionUser(result);
      notifyListeners();
      // print('loginnn${jsonEncode(_vMitra)}');
      onSuccess?.call();
    } catch (e) {
      print('Error in postInsertNilaiAssessmentData: $e');
      onError?.call();
    }
  }

  void setCurrentSessionUser(Vmitra? user) {
    // print('login qqq');
    if (user == null) {
      return;
    }
    // print('login ${user.nomor}');

    userNomor = user.nomor;
    notifyListeners();
  }

  void clear() {
    usernameController.clear();
    passwordController.clear();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/logbook_pendaftar_dokumen_provider.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/logbook_pendaftar_provider.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/quis_jawaban_pilihan_provider.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/quis_jawaban_vmitra_provider.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/quis_pertanyaan_provider.dart';
import 'package:mitra_app/features/presentation/providers/delete_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/insert_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/kategori_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/read_vassessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/update_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/vmitra_providers.dart';
import 'package:mitra_app/features/presentation/providers/vpendaftar_providers.dart';
import 'package:mitra_app/features/presentation/splash_screen_page.dart';
import 'package:mitra_app/injection.dart';
import 'package:provider/provider.dart';

void main() {
  initInjection();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => KategoriAssessmentProviders(
            getKategoriAssessment: locator(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => VmitraProviders(
            getVmitra: locator(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UpdateAssessmentProvider(
            updateAssessment: locator(),
          ),
        ),

        ListenableProxyProvider<VmitraProviders, InsertAssessmentProviders>(
          update: (context, vMitra, prevPendaftarProvider) =>
              InsertAssessmentProviders(
            postInsertNilaiAssessment: locator(),
          ),
        ),

        ListenableProxyProvider<VmitraProviders, VReadAssessmentProviders>(
            update: (context, vMitra, prevVReadassessmentProvider) {
          return VReadAssessmentProviders(
            idMitra: vMitra.userNomor,
            getVReadAssessment: locator(),
          );
        }),

        ChangeNotifierProvider(
          create: (_) => DeleteAssessmentProvider(
            deleteAssessment: locator(),
          ),
        ),

        ChangeNotifierProvider(
            create: (_) => LogbookPendaftarMonitoringProvider()),
        ChangeNotifierProvider(create: (_) => QuisPertanyaanProvider()),
        ChangeNotifierProvider(create: (_) => QuisJawabanPilihanProvider()),
        ChangeNotifierProvider(create: (_) => QuisJawabanVMitraProvider()),

        ChangeNotifierProvider(
            create: (_) => LogbookPendaftarDokumenProvider()),
        // print('qqq ${vMitra.userNomor}');
        ListenableProxyProvider<VmitraProviders, VpendaftarProviders>(
            update: (context, vMitra, prevPendaftarProvider) {
          return VpendaftarProviders(
            getVpendaftar: locator(),
            idMitra: vMitra.userNomor,
          );
        }),
        // ListenableProxyProvider<VmitraProviders, VpendaftarProviders>(
        //   update: (context, vMitra, prevPendaftarProvider) =>
        //       VpendaftarProviders(
        //     getVpendaftar: locator(),
        //     idMitra: vMitra.userNomor,
        //   // print('qqq ${vMitra.userNomor}'),
        //   ),
        // ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}

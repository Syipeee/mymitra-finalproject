import 'package:get_it/get_it.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/delete_assessment_remote_datasource.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/insert_assessment_remote_datasource.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/kategori_assessment_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/read_vassessment_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/update_assessment_remote_datasource.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/vmitra_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/datasource/vpendaftar_remote_data_source.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/delete_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/insert_nilai_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/kategori_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/read_vassessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/update_assessment_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/vmitra_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/repository/vpendaftar_repository.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_kategori_assessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_vassessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_vmitra.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/get_vpendaftar.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/post_assessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/post_del_assessment.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/domain/usecase/update_assessment.dart';
import 'package:mitra_app/features/presentation/providers/delete_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/kategori_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/update_assessment_providers.dart';

final locator = GetIt.instance;

void initInjection() {
  // datasource
  locator.registerLazySingleton<KategoriAssessmentRemoteDataSource>(
      () => KategoriAssessmentRemoteDataSourceImpl());

  locator.registerLazySingleton<InsertAssessmentRemoteDataSource>(
      () => InsertNilaiAssessmentRemoteDataSourceImpl());

  locator.registerLazySingleton<VpendaftarRemoteDataSource>(
      () => VpendaftarRemoteDataSourceImpl());

  locator.registerLazySingleton<VmitraRemoteDataSource>(
      () => VmitraRemoteDataSourceImpl());

  locator.registerLazySingleton<VReadAssessmentRemoteDataSource>(
      () => VReadNilaiAssessmentRemoteDataSourceImpl());
  locator.registerLazySingleton<UpdateAssessmentRemoteDataSource>(
      () => UpdateAssessmentRemoteDataSourceImpl());

  locator.registerLazySingleton<DeleteAssessmentRemoteDataSource>(
      () => DeleteAssessmentRemoteDataSourceImpl());

  // repository
  locator.registerLazySingleton<KategoriAssessmentRepository>(
      () => KategoriAssessmentRepositoryImpl(
            remoteDataSource: locator<KategoriAssessmentRemoteDataSource>(),
          ));
  locator.registerLazySingleton<InsertAssessmentRepository>(
      () => InsertNilaiAssessmentRepositoryImpl(
            remoteDataSource: locator<InsertAssessmentRemoteDataSource>(),
          ));

  locator.registerLazySingleton<VpendaftarRepository>(
      () => VpendaftarRepositoryImpl(
            remoteDataSource: locator<VpendaftarRemoteDataSource>(),
          ));

  locator.registerLazySingleton<VmitraRepository>(() => VmitraRepositoryImpl(
        remoteDataSource: locator<VmitraRemoteDataSource>(),
      ));

  locator.registerLazySingleton<VReadAssessmentRepository>(
      () => VReadAssessmentRepositoryImpl(
            remoteDataSource: locator<VReadAssessmentRemoteDataSource>(),
          ));
  locator.registerLazySingleton<UpdateAssessmentRepository>(
      () => UpdateAssessmentRepositoryImpl(
            remoteDataSource: locator<UpdateAssessmentRemoteDataSource>(),
          ));

  locator.registerLazySingleton<DeleteAssessmentRepository>(
      () => DeleteAssessmentRepositoryImpl(
            remoteDataSource: locator<DeleteAssessmentRemoteDataSource>(),
          ));

  // usecase
  locator.registerLazySingleton(() => GetKategoriAssessment(locator()));
  locator.registerLazySingleton(() => PostInsertAssessment(locator()));
  locator.registerLazySingleton(() => GetVpendaftar(locator()));
  locator.registerLazySingleton(() => GetVmitra(locator()));
  locator.registerLazySingleton(() => UpdateAssessment(locator()));
  locator.registerLazySingleton(() => DeleteAssessment(locator()));
  locator.registerLazySingleton(() => GetVReadAssessment(locator()));

  // provider
  locator.registerFactory(() => KategoriAssessmentProviders(
        getKategoriAssessment: locator(),
      ));

  locator.registerFactory(() => UpdateAssessmentProvider(
        updateAssessment: locator(),
      ));

  locator.registerFactory(() => DeleteAssessmentProvider(
        deleteAssessment: locator(),
      ));
}

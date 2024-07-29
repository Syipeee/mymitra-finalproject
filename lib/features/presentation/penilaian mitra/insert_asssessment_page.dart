// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/kategori_assessment_response.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/read_assessement_page.dart';
import 'package:mitra_app/features/components/colors.dart';
import 'package:mitra_app/features/components/custom_appbar.dart';
import 'package:mitra_app/features/components/custom_form.dart';

import 'package:mitra_app/features/presentation/providers/insert_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/kategori_assessment_providers.dart';
import 'package:provider/provider.dart' as provider;

class InsertAssessmentPage extends StatefulWidget {
  const InsertAssessmentPage({
    Key? key,
    required this.supre,
  }) : super(key: key);

  final VPendaftar supre;

  @override
  State<InsertAssessmentPage> createState() => _InsertAssessmentState();
}

class _InsertAssessmentState extends State<InsertAssessmentPage> {
  KategoriAssessment? selectedCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.Provider.of<KategoriAssessmentProviders>(
        context,
        listen: false,
      ).getKategoriAssessmentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Penilaian Pembimibing',
      ),
      body: provider.Consumer<KategoriAssessmentProviders>(
        builder: (BuildContext context, kategoriProvider, child) {
          final kategoriAssessments = kategoriProvider.kategoriAssessments;

          if (kategoriAssessments == null) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: yellowPens,
                valueColor: AlwaysStoppedAnimation(bluePens),
              ),
            );
          }
          return ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Pendaftar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.supre.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Nama Mitra',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.supre.namaVmitra,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Kategori Assessment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: kategoriAssessments.map((kategori) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedCategory == kategori
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CheckboxListTile(
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            title: Text(kategori.kategoriAssessment ?? ''),
                            value: selectedCategory == kategori,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedCategory = value! ? kategori : null;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Input Nilai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomForm(
                      hintText: 'Input Nilai',
                      maxLength: 2,
                      textInputType: TextInputType.number,
                      controller: context
                          .read<InsertAssessmentProviders>()
                          .nilaiController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon masukkan nilai';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isLoading || selectedCategory == null
                            ? null
                            : () {
                                setState(() {
                                  _isLoading = true;
                                });
                                context
                                    .read<InsertAssessmentProviders>()
                                    .postInsertNilaiAssessmentData(
                                      kategoriAssessment: selectedCategory!,
                                      pendaftar: widget.supre,
                                      vmitra: widget.supre,
                                      nilai: context
                                          .read<InsertAssessmentProviders>()
                                          .nilaiController
                                          .text,
                                      onSuccess: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text('Data berhasil disimpan'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        context
                                            .read<InsertAssessmentProviders>()
                                            .nilaiController
                                            .clear();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VReadAssessmentPage(
                                              vPendaftar: widget.supre,
                                            ),
                                          ),
                                        );
                                      },
                                      onError: () {
                                        if (context
                                            .read<InsertAssessmentProviders>()
                                            .nilaiController
                                            .text
                                            .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Nilai belum diisi',
                                              ),
                                              backgroundColor: Colors.amber,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Data gagal disimpan karena duplikasi',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        context
                                            .read<InsertAssessmentProviders>()
                                            .nilaiController
                                            .clear();
                                      },
                                    );
                              },
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                backgroundColor: yellowPens,
                                valueColor: AlwaysStoppedAnimation(bluePens),
                              )
                            : const Text(
                                'Simpan',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mitra_app/features/components/theme.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/models/quis_jawaban_pilihan_model.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/quis_pertanyaan_provider.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/quis_jawaban_pilihan_provider.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/providers/quis_jawaban_vmitra_provider.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';
import 'package:mitra_app/features/presentation/providers/vmitra_providers.dart';
import 'package:provider/provider.dart';

class FormKuisioner extends StatefulWidget {
  final VPendaftar noPendaftar;

  const FormKuisioner({
    Key? key,
    required this.noPendaftar,
  }) : super(key: key);

  @override
  State<FormKuisioner> createState() => _FormKuisionerState();
}

class _FormKuisionerState extends State<FormKuisioner> {
  late int idMitra;
  final Map<String, String?> _selectedJawaban = {};
  final TextEditingController _textEditingController = TextEditingController();
  String _pertanyaanIsianNomor = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mitraProvider =
          Provider.of<VmitraProviders>(context, listen: false);
      idMitra = int.parse(mitraProvider.userNomor);

      final quisPertanyaanProvider =
          Provider.of<QuisPertanyaanProvider>(context, listen: false);
      quisPertanyaanProvider.fetchQuisPertanyaan(idMitra);

      final quisJawabanPilihanProvider =
          Provider.of<QuisJawabanPilihanProvider>(context, listen: false);
      quisJawabanPilihanProvider.fetchQuisJawabanPilihan(idMitra);
    });
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
    });

    final quisJawabanVMitraProvider =
        Provider.of<QuisJawabanVMitraProvider>(context, listen: false);

    try {
      for (final entry in _selectedJawaban.entries) {
        final quisPertanyaan = entry.key;
        final quisJawabanPilihan = entry.value ?? "";
        final jawabanIsian = quisPertanyaan == _pertanyaanIsianNomor
            ? _textEditingController.text
            : "";

        await quisJawabanVMitraProvider.insertQuisJawabanVMitra(
          widget.noPendaftar.nomor,
          quisPertanyaan,
          quisJawabanPilihan,
          jawabanIsian,
        );
      }

      if (_pertanyaanIsianNomor.isNotEmpty) {
        await quisJawabanVMitraProvider.insertQuisJawabanVMitra(
          widget.noPendaftar.nomor,
          _pertanyaanIsianNomor,
          "", // Kosongkan jawaban pilihan jika ini jawaban isian
          _textEditingController.text,
        );
      }

      // Jika berhasil, tampilkan pesan sukses dan kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jawaban berhasil disimpan')),
      );
      Navigator.pop(context);
    } catch (error) {
      // Tangani kesalahan dan tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan jawaban')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                size: 24,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              'Form Kuisioner',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Consumer2<QuisPertanyaanProvider, QuisJawabanPilihanProvider>(
        builder: (context, quisPertanyaanProvider, quisJawabanPilihanProvider,
            child) {
          if (quisPertanyaanProvider.isLoading ||
              quisJawabanPilihanProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (quisPertanyaanProvider.quisPertanyaanList.isEmpty) {
            return const Center(
              child: Text('No quis questions found.'),
            );
          }

          final quisJawabanPilihanMap = quisJawabanPilihanProvider
              .quisJawabanPilihanList
              .fold<Map<String, List<QuisJawabanPilihan>>>({}, (map, item) {
            if (!map.containsKey(item.quisPertanyaan)) {
              map[item.quisPertanyaan] = [];
            }
            map[item.quisPertanyaan]!.add(item);
            return map;
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: quisPertanyaanProvider.quisPertanyaanList.length,
                  itemBuilder: (context, index) {
                    final quisPertanyaan =
                        quisPertanyaanProvider.quisPertanyaanList[index];
                    final quisJawabanList =
                        quisJawabanPilihanMap[quisPertanyaan.nomor] ?? [];
                    String? selectedJawaban =
                        _selectedJawaban[quisPertanyaan.nomor];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(quisPertanyaan.pertanyaan),
                        ),
                        if (index == 2) // Kondisi untuk pertanyaan ketiga
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: bluePens),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: TextField(
                                controller: _textEditingController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _pertanyaanIsianNomor =
                                        quisPertanyaan.nomor;
                                  });
                                },
                              ),
                            ),
                          ),
                        ...quisJawabanList.map((quisJawaban) {
                          return RadioListTile<String>(
                            title: Text(quisJawaban.jawaban),
                            value: quisJawaban.nomor,
                            groupValue: selectedJawaban,
                            activeColor: bluePens,
                            onChanged: (value) {
                              setState(() {
                                _selectedJawaban[quisPertanyaan.nomor] = value;
                              });
                            },
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      backgroundColor: _isLoading ? Colors.grey : bluePens,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const SizedBox(
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

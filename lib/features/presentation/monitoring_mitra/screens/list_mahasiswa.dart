import 'package:flutter/material.dart';
import 'package:mitra_app/features/presentation/providers/vmitra_providers.dart';
import 'package:mitra_app/features/presentation/providers/vpendaftar_providers.dart';
import 'package:provider/provider.dart';
import 'package:mitra_app/features/components/colors.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/screens/list_mingguan.dart';

class ListMahasiswaLogbookMbkm extends StatefulWidget {
  const ListMahasiswaLogbookMbkm({Key? key}) : super(key: key);

  @override
  State<ListMahasiswaLogbookMbkm> createState() =>
      _ListMahasiswaLogbookMbkmState();
}

class _ListMahasiswaLogbookMbkmState extends State<ListMahasiswaLogbookMbkm> {
  Map<String, bool> _isLoadingMap = {};

  late String idMitra;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<VpendaftarProviders>(context, listen: false);
    provider.getVpendaftarData();

    // Get the idMitra from VmitraProviders
    final mitraProvider = Provider.of<VmitraProviders>(context, listen: false);
    idMitra = mitraProvider.userNomor; // Assign idMitra
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
            const SizedBox(width: 20),
            const Text(
              'Mahasiswa MBKM',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Consumer<VpendaftarProviders>(
          builder: (context, provider, _) {
            if (provider.vpendaftars == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: provider.vpendaftars!.length,
              itemBuilder: (context, index) {
                final vPendaftar = provider.vpendaftars![index];
                String noPendaftar = vPendaftar.nomor;
                bool isLoading = _isLoadingMap.containsKey(noPendaftar)
                    ? _isLoadingMap[noPendaftar]!
                    : false;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _isLoadingMap[noPendaftar] = true;
                    });
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListMingguanLogbook(
                            noPendaftar: vPendaftar,
                            startDate: vPendaftar.tanggalMulai,
                            endDate: vPendaftar.tanggalBerakhir,
                            idMitra: idMitra, // Pass the idMitra here
                          ),
                        ),
                      ).then((value) {
                        setState(() {
                          _isLoadingMap[noPendaftar] = false;
                        });
                      });
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vPendaftar.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: SizedBox(
                                    width: 90,
                                    height: 20,
                                    child: Center(
                                      child: Text(vPendaftar.nrp),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: SizedBox(
                                    width: 185,
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        vPendaftar.namaKegiatan,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              vPendaftar.namaVmitra,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: yellowPens,
                                      valueColor:
                                          AlwaysStoppedAnimation(bluePens),
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: bluePens,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          'Lihat Logbook',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

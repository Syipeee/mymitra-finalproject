import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_app/features/components/colors.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/screens/form_kuisioner.dart';
import 'package:mitra_app/features/presentation/monitoring_mitra/screens/list_harian.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';

class ListMingguanLogbook extends StatefulWidget {
  const ListMingguanLogbook({
    Key? key,
    required this.noPendaftar,
    required this.startDate,
    required this.endDate,
    required this.idMitra,
  }) : super(key: key);

  final VPendaftar noPendaftar;
  final String startDate;
  final String endDate;
  final String idMitra;

  @override
  State<ListMingguanLogbook> createState() => _ListMingguanLogbookState();
}

class _ListMingguanLogbookState extends State<ListMingguanLogbook> {
  Map<String, bool> _loadingLihatMap = {};
  Map<String, bool> _loadingKuisionerMap = {};

  List<String> logbookEntries = [];

  @override
  void initState() {
    super.initState();
    print('Start Date: ${widget.startDate}');
    print('End Date: ${widget.endDate}');
    try {
      if (widget.startDate.isNotEmpty && widget.endDate.isNotEmpty) {
        generateWeeklyLogbookEntries(widget.startDate, widget.endDate);
      } else {
        print('Tanggal mulai atau berakhir kosong');
      }
    } catch (e) {
      print("Error generating logbook entries: $e");
    }
  }

  DateTime parseDate(String dateStr) {
    print('Parsing date: $dateStr'); // Tambahkan log ini
    try {
      if (dateStr.isEmpty) {
        throw FormatException('Tanggal kosong');
      }
      final parts = dateStr.split('-');
      if (parts.length != 3) {
        throw FormatException('Format tanggal tidak valid: $dateStr');
      }
      final day = int.parse(parts[0]);
      final month = _parseMonth(parts[1]);
      final year = 2000 + int.parse(parts[2]); // Asumsi tahun 2000-an
      return DateTime(year, month, day);
    } catch (e) {
      throw FormatException('Error parsing date: $e');
    }
  }

  int _parseMonth(String monthStr) {
    switch (monthStr.toUpperCase()) {
      case 'JAN':
        return DateTime.january;
      case 'FEB':
        return DateTime.february;
      case 'MAR':
        return DateTime.march;
      case 'APR':
        return DateTime.april;
      case 'MAY':
        return DateTime.may;
      case 'JUN':
        return DateTime.june;
      case 'JUL':
        return DateTime.july;
      case 'AUG':
        return DateTime.august;
      case 'SEP':
        return DateTime.september;
      case 'OCT':
        return DateTime.october;
      case 'NOV':
        return DateTime.november;
      case 'DEC':
        return DateTime.december;
      default:
        throw Exception('Bulan tidak valid: $monthStr');
    }
  }

  void generateWeeklyLogbookEntries(String start, String end) {
    try {
      DateTime startDate = parseDate(start);
      DateTime endDate = parseDate(end);
      List<String> entries = [];

      // Jika startDate bukan hari Senin, buat rentang pertama dari startDate hingga Jumat
      if (startDate.weekday != DateTime.monday) {
        DateTime weekEnd =
            startDate.add(Duration(days: DateTime.friday - startDate.weekday));
        if (weekEnd.isAfter(endDate)) {
          weekEnd = endDate;
        }
        entries.add(
            '${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(weekEnd)}');
        startDate = weekEnd.add(Duration(days: 1)); // Pindahkan ke hari Sabtu
      }

      // Pindahkan startDate ke hari Senin minggu berikutnya jika berada di akhir pekan
      if (startDate.weekday > DateTime.friday) {
        startDate = startDate
            .add(Duration(days: DateTime.monday - startDate.weekday + 7));
      }

      // Buat rentang mingguan dari Senin hingga Jumat
      while (
          startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
        DateTime weekEnd = startDate.add(Duration(days: 4));
        if (weekEnd.isAfter(endDate)) {
          weekEnd = endDate;
        }

        entries.add(
            '${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(weekEnd)}');
        startDate = startDate.add(Duration(days: 7));

        // Pindahkan startDate ke hari Senin minggu berikutnya
        if (startDate.weekday > DateTime.friday) {
          startDate = startDate
              .add(Duration(days: DateTime.monday - startDate.weekday + 7));
        }
      }

      setState(() {
        logbookEntries = entries;
      });
    } catch (e) {
      print("Error generating logbook entries: $e");
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
              'Logbook Mingguan Mahasiswa',
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
        child: ListView.builder(
          itemCount: logbookEntries.length,
          itemBuilder: (BuildContext context, int index) {
            final entry = logbookEntries[index];
            final isLoadingLihat = _loadingLihatMap[entry] ?? false;
            final isLoadingKuisioner = _loadingKuisionerMap[entry] ?? false;
            return Column(
              children: [
                buildLogbookEntry(
                    entry, index + 1, isLoadingLihat, isLoadingKuisioner),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildLogbookEntry(String entry, int weekNumber, bool isLoadingLihat,
      bool isLoadingKuisioner) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry,
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
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 20,
                    child: Center(
                      child: Text('Minggu Ke - $weekNumber'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: isLoadingLihat
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: yellowPens,
                            valueColor: AlwaysStoppedAnimation(bluePens),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _loadingLihatMap[entry] = true;
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListHarianLogbook(
                                    idMitra: widget.idMitra,
                                    rangeDates: entry,
                                    noPendaftar: widget.noPendaftar,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  _loadingLihatMap[entry] = false;
                                });
                              });
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: bluePens,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Lihat',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: isLoadingKuisioner
                      ? const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: yellowPens,
                            valueColor: AlwaysStoppedAnimation(bluePens),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _loadingKuisionerMap[entry] = true;
                            });
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKuisioner(
                                    noPendaftar: widget.noPendaftar,
                                  ),
                                ),
                              ).then((value) {
                                setState(() {
                                  _loadingKuisionerMap[entry] = false;
                                });
                              });
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: bluePens,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Isi Kuisioner',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

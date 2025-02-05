import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mitra_app/features/presentation/penilaian%20mitra/data/model/vpendaftar_model.dart';
import 'package:mitra_app/features/components/colors.dart';
import 'package:mitra_app/features/components/custom_appbar.dart';
import 'package:mitra_app/features/components/custom_bottom_sheet.dart';
import 'package:mitra_app/features/presentation/providers/delete_assessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/read_vassessment_providers.dart';
import 'package:mitra_app/features/presentation/providers/update_assessment_providers.dart';
import 'package:provider/provider.dart' as provider;

class VReadAssessmentPage extends StatefulWidget {
  final VPendaftar? vPendaftar;
  const VReadAssessmentPage({
    Key? key,
    this.vPendaftar,
  }) : super(key: key);

  @override
  State<VReadAssessmentPage> createState() => _VReadAssessmentPageState();
}

class _VReadAssessmentPageState extends State<VReadAssessmentPage> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<
      RefreshIndicatorState>(); // Tambahkan key untuk RefreshIndicator
  bool _refreshing = false; // Tambahkan atribut refreshing
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    if (widget.vPendaftar != null) {
      provider.Provider.of<VReadAssessmentProviders>(context, listen: false)
          .idMahasiswa = (widget.vPendaftar?.nomorMahasiswa ?? '');
    }
    _future = _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _refreshing = true;
    });
    await provider.Provider.of<VReadAssessmentProviders>(
      context,
      listen: false,
    ).getVReadAssessmentData();
    setState(() {
      _refreshing = false;
    });
  }

  void _onOperationComplete() {
    setState(() {
      _future = _refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Penilaian MBKM Pembimbing",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: RefreshIndicator(
          backgroundColor: yellowPens,
          key: _refreshIndicatorKey, // Set key untuk RefreshIndicator
          onRefresh: _refreshData, // Tambahkan handler onRefresh
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari berdasarkan kategori',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    suffixIcon: searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: yellowPens,
                          valueColor: AlwaysStoppedAnimation(bluePens),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return provider.Consumer<VReadAssessmentProviders>(
                        builder: (context, provider, child) {
                          final vReadAssessments = provider.readVAssessments;

                          final filteredVAssessments =
                              vReadAssessments!.where((assessment) {
                            return assessment.namaKategoriAssessment
                                .toLowerCase()
                                .contains(
                                  searchController.text.toLowerCase(),
                                );
                          }).toList();
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredVAssessments.length,
                            itemBuilder: (context, index) {
                              final readVAssessment =
                                  filteredVAssessments[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 1,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24.0,
                                          vertical: 16.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              readVAssessment.nama,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              readVAssessment.nrp,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6.0,
                                                vertical: 4.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: bluePens,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 1,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                readVAssessment.tanggal,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            ClipRRect(
                                              child: Slidable(
                                                endActionPane: ActionPane(
                                                  extentRatio: 0.30,
                                                  motion: const StretchMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: (context) {
                                                        _showEditDialog(
                                                          context,
                                                          readVAssessment.nomor,
                                                          readVAssessment.nilai,
                                                          readVAssessment
                                                              .tanggal,
                                                        );
                                                      },
                                                      backgroundColor:
                                                          yellowPens,
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.edit,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 6.0,
                                                      ),
                                                    ),
                                                    SlidableAction(
                                                      onPressed: (context) {
                                                        _showDeleteDialog(
                                                          context,
                                                          readVAssessment.nomor,
                                                        );
                                                      },
                                                      backgroundColor:
                                                          const Color(
                                                        0xFFFE4A49,
                                                      ),
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 6.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 8.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child: Text(
                                                              'Kategori Assessment',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              'Nilai',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child: Text(
                                                              readVAssessment
                                                                  .namaKategoriAssessment,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              readVAssessment
                                                                  .nilai,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String nomor,
    String nilai,
    String tanggal,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigatorContext =
          Navigator.of(context, rootNavigator: true).overlay!.context;

      EditDialog.show(navigatorContext, context, tanggal, nilai, (
        String newValue,
        String newTanggal,
      ) {
        provider.Provider.of<UpdateAssessmentProvider>(navigatorContext,
                listen: false)
            .updateAssessmentData(
          nilai: newValue,
          nomor: nomor,
          tanggal: newTanggal,
          onSuccess: () {
            _onOperationComplete();
            if (newTanggal != tanggal) {
              ScaffoldMessenger.of(navigatorContext)
                  .showSnackBar(const SnackBar(
                content: Text('Tanggal berhasil diupdate.'),
                backgroundColor: Colors.blue,
              ));
            } else {
              ScaffoldMessenger.of(navigatorContext)
                  .showSnackBar(const SnackBar(
                content: Text('Nilai berhasil diupdate.'),
                backgroundColor: Colors.green,
              ));
            }
          },
          onError: () {
            if (newTanggal != tanggal) {
              ScaffoldMessenger.of(navigatorContext)
                  .showSnackBar(const SnackBar(
                content: Text('Gagal mengupdate tanggal.'),
                backgroundColor: Colors.red,
              ));
            } else {
              ScaffoldMessenger.of(navigatorContext)
                  .showSnackBar(const SnackBar(
                content: Text('Gagal mengupdate nilai.'),
                backgroundColor: Colors.red,
              ));
            }
          },
        );
      });
    });
  }

  void _showDeleteDialog(
    BuildContext context,
    String nomor,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigatorContext =
          Navigator.of(context, rootNavigator: true).overlay!.context;

      DeleteDialog.show(navigatorContext, () {
        provider.Provider.of<DeleteAssessmentProvider>(navigatorContext,
                listen: false)
            .deleteAssessmentData(
          nomor: nomor,
          onSuccess: () {
            _onOperationComplete();
            ScaffoldMessenger.of(navigatorContext).showSnackBar(const SnackBar(
              content: Text('Nilai berhasil dihapus.'),
              backgroundColor: Colors.green,
            ));
          },
          onError: () {
            ScaffoldMessenger.of(navigatorContext).showSnackBar(const SnackBar(
              content: Text('Gagal menghapus nilai.'),
              backgroundColor: Colors.red,
            ));
          },
        );
      });
    });
  }
}

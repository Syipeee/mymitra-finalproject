import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mitra_app/features/components/custom_form.dart';

class EditDialog {
  static void show(
    BuildContext parentContext,
    BuildContext context,
    String initialTanggal,
    String initialNilai,
    Function(String, String) onSaveWithDate,
  ) {
    TextEditingController nilaiController =
        TextEditingController(text: initialNilai);
    TextEditingController tanggalController =
        TextEditingController(text: initialTanggal);

    DateTime? originalDate;
    try {
      originalDate = DateFormat('dd-MM-yyyy').parse(initialTanggal);
    } catch (e) {
      originalDate = DateTime.now();
    }

    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Edit Nilai MBKM',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomForm(
                    hintText: 'Nilai MBKM',
                    textInputType: TextInputType.number,
                    maxLength: 2,
                    controller: nilaiController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Harap isi nilai MBKM';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _selectDate(
                        context,
                        tanggalController,
                      );
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: tanggalController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Update Tanggal',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      DateTime? selectedDate;
                      try {
                        selectedDate = DateFormat('dd-MM-yyyy')
                            .parse(tanggalController.text);
                      } catch (e) {
                        selectedDate = originalDate;
                      }

                      if (selectedDate!.isBefore(DateTime.now()) ||
                          selectedDate == originalDate) {
                        onSaveWithDate(
                          nilaiController.text,
                          tanggalController.text,
                        );
                        if (Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                      } else {
                        if (parentContext.mounted) {
                          ScaffoldMessenger.of(parentContext).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Tidak bisa memilih tanggal yang akan datang.'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null && picked.isBefore(now)) {
      final formattedDate = DateFormat('dd-MMM-yyyy').format(picked);
      controller.text = formattedDate;
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak bisa memilih tanggal yang akan datang.'),
          ),
        );
      }
    }
  }
}

class DeleteDialog {
  static void show(
    BuildContext parentContext,
    VoidCallback onDelete,
  ) {
    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Nilai MBKM'),
          content:
              const Text('Apakah Anda yakin ingin menghapus nilai MBKM ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                onDelete(); // Panggil fungsi onDelete saat tombol "Hapus" ditekan
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}

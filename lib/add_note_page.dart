import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil list notes lama
    String? stored = prefs.getString('notes');
    List<Map<String, dynamic>> notes = [];

    if (stored != null) {
      notes = List<Map<String, dynamic>>.from(json.decode(stored));
    }

    // Note baru
    Map<String, dynamic> newNote = {
      'title': _titleController.text,
      'description': _contentController.text,
      'date': _dateController.text,
      'is_done': false,
    };

    // Tambahkan ke list
    notes.add(newNote);

    // Simpan kembali
    await prefs.setString('notes', json.encode(notes));

    // Notifikasi
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Note berhasil disimpan')));

    Navigator.pop(context); // kembali ke home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Judul Catatan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Masukkan judul catatan',
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Isi Catatan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Masukkan isi catatan',
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Tanggal Dibuat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _dateController,
              readOnly: true, // supaya tidak bisa diketik
              decoration: const InputDecoration(
                hintText: 'Pilih tanggal catatan',
              ),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate == null) return;

                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime == null) return;

                final combinedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                final formattedDate =
                    "${combinedDateTime.day.toString().padLeft(2, '0')}/${combinedDateTime.month.toString().padLeft(2, '0')}/${combinedDateTime.year} ${combinedDateTime.hour.toString().padLeft(2, '0')}:${combinedDateTime.minute.toString().padLeft(2, '0')}";

                setState(() {
                  _dateController.text = formattedDate;
                });
              },
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: saveNote,
              child: const Text('Buat Catatan'),
            ),
          ],
        ),
      ),
    );
  }
}

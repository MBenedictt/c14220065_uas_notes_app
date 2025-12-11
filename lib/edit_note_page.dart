import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EditNotePage extends StatefulWidget {
  final Map<String, dynamic> note;
  final int index;

  const EditNotePage({super.key, required this.note, required this.index});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note['title']);
    _contentController = TextEditingController(
      text: widget.note['description'],
    );
    _dateController = TextEditingController(text: widget.note['date']);
  }

  void saveEdit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Ambil list lama
    String? stored = prefs.getString('notes');
    List<Map<String, dynamic>> notes = List<Map<String, dynamic>>.from(
      json.decode(stored!),
    );

    // Update note lama sesuai index
    notes[widget.index] = {
      'title': _titleController.text,
      'description': _contentController.text,
      'date': _dateController.text,
      'is_done': widget.note['is_done'],
    };

    // Simpan kembali
    await prefs.setString('notes', json.encode(notes));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Judul Catatan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: "Edit judul"),
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
              decoration: const InputDecoration(hintText: "Edit deskripsi"),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tanggal Dibuat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              readOnly: true,
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
              onPressed: saveEdit,
              child: const Text("Simpan Perubahan"),
            ),
          ],
        ),
      ),
    );
  }
}

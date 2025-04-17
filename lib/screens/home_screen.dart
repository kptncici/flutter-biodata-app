import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/profile_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Student> students = [
    Student(
      name: "Nurfadilla Rhamadani",
      nim: "23621039",
      major: "Sistem Informasi",
      photoAsset: "assets/images/gambar1.jpeg",
    ),
    Student(
      name: "Monkey D Luffy",
      nim: "23621000",
      major: "Sistem Informasi",
      photoAsset: "assets/images/gambar2.png",
    ),
  ];

  void _editStudent(int index) {
    final student = students[index];
    final nameController = TextEditingController(text: student.name);
    final nimController = TextEditingController(text: student.nim);
    final majorController = TextEditingController(text: student.major);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: nimController,
                  decoration: const InputDecoration(labelText: 'NIM'),
                ),
                TextField(
                  controller: majorController,
                  decoration: const InputDecoration(labelText: 'Major'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    nimController.text.isEmpty ||
                    majorController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Semua field harus diisi')),
                  );
                  return;
                }

                setState(() {
                  students[index] = Student(
                    name: nameController.text,
                    nim: nimController.text,
                    major: majorController.text,
                    photoAsset: student.photoAsset,
                  );
                });

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${students[index].name} berhasil diperbarui',
                    ),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data berhasil dihapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biodata Diri"), centerTitle: true),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ProfileCard(
            student: students[index],
            onEdit: () => _editStudent(index),
            onDelete: () => _deleteStudent(index),
          );
        },
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:asermpharma/src/service/http.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class POST extends StatefulWidget {
  const POST({super.key});

  @override
  State<POST> createState() => _POSTState();
}

// Contrôleurs pour chaque champ de saisie
TextEditingController prospectNameController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController rdvObjectController = TextEditingController();
TextEditingController nextRdvController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController contactController = TextEditingController();
TextEditingController pharmacoVigilanceController = TextEditingController();

class _POSTState extends State<POST> {
  bool _isLoading = false;
  String? _degree; // Variable pour le degré
  Position? _currentPosition;
  File? _selectedFile; // Variable pour stocker le fichier temporairement

  @override
  void initState() {
    super.initState();
    _requestCurrentPosition();
  }

  Future<void> _requestCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Veuillez activer les services de localisation")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("La permission de localisation est refusée")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Les permissions de localisation sont définitivement refusées")),
      );
      return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
  }

  void _submitData() async {
    // Validation des champs obligatoires
    if (prospectNameController.text.isEmpty ||
        dateController.text.isEmpty ||
        _degree == null ||
        rdvObjectController.text.isEmpty ||
        nextRdvController.text.isEmpty ||
        timeController.text.isEmpty ||
        contactController.text.isEmpty ||
        pharmacoVigilanceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Position non récupérée")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      "prospectName": prospectNameController.text,
      "date": dateController.text,
      "degree": _degree,
      "rdvObject": rdvObjectController.text,
      "nextRdv": nextRdvController.text,
      "time": timeController.text,
      "contact": contactController.text,
      "pharmacoVigilance": pharmacoVigilanceController.text,
      "latitude": _currentPosition!.latitude,
      "longitude": _currentPosition!.longitude,
    };

    try {
      final response = await Http.postReporting(data);

      if (response.statusCode == 200) {
        // Téléchargement du fichier après que le rapport a été soumis
        if (_selectedFile != null) {
          await _uploadFile();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Rapport et fichier soumis avec succès !")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Échec de la soumission du rapport.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Rapport et fichier soumis avec succès !")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadFile() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.1.108:5002/v1/upload"),
    );

    if (_selectedFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('file', _selectedFile!.path));

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("authToken");

      request.headers.addAll({"Authorization": "Bearer $token"});

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fichier téléchargé avec succès !")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Échec du téléchargement : ${response.statusCode}")),
        );
      }
    }
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg', 'docx'],
    );

    if (result != null) {
      setState(() {
        _selectedFile =
            File(result.files.single.path!); // Stocker le fichier sélectionné
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Fichier sélectionné. Il sera téléchargé lors de l'envoi du rapport.")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aucun fichier sélectionné")),
      );
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout de Prospect")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: prospectNameController,
              decoration: const InputDecoration(labelText: "Nom du prospect"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "Date"),
              readOnly: true,
              onTap: () => _pickDate(dateController),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _degree,
              decoration: const InputDecoration(labelText: "Degré"),
              items: ['A', 'B', 'C', 'D', 'E', 'F']
                  .map((degree) => DropdownMenuItem(
                        value: degree,
                        child: Text(degree),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _degree = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: rdvObjectController,
              decoration: const InputDecoration(labelText: "Objet du rdv"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nextRdvController,
              decoration: const InputDecoration(labelText: "Prochain rdv"),
              readOnly: true,
              onTap: () => _pickDate(nextRdvController),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: "Heure"),
              readOnly: true,
              onTap: _pickTime,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: "Contact"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectFile,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                backgroundColor: const Color(0xFFED700B),
              ),
              child: const Text(
                "Ajouter un fichier",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pharmacoVigilanceController,
              decoration:
                  const InputDecoration(labelText: "Pharmaco Vigilance"),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitData,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                backgroundColor: const Color(0xFF01172D),
                shape: const StadiumBorder(),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Valider",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

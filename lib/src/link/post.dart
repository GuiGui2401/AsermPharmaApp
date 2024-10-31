// ignore_for_file: use_build_context_synchronously

import 'package:asermpharma/src/service/http.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class POST extends StatefulWidget {
  const POST({super.key});

  @override
  State<POST> createState() => _POSTState();
}

// Contrôleurs pour chaque champ de saisie
TextEditingController prospectNameController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController degreeController = TextEditingController();
TextEditingController rdvObjectController = TextEditingController();
TextEditingController nextRdvController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController contactController = TextEditingController();
TextEditingController pharmacoVigilanceController = TextEditingController();

class _POSTState extends State<POST> {
  bool _isLoading = false;
  Position? _currentPosition;

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
      "degree": degreeController.text,
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

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Rapport soumis avec succès !")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Échec de la soumission du rapport.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : ${e.toString()}")),
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
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: degreeController,
              decoration: const InputDecoration(labelText: "Degré"),
              keyboardType: TextInputType.number,
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
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: "Heure"),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: "Contact"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Fonctionnalité pour ajouter un fichier
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                backgroundColor: const Color(0xFFED700B),
              ),
              child: const Text(
                "Ajouter un fichier complémentaire",
                style: TextStyle(fontSize: 20, color: Color(0xFF01172D)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: pharmacoVigilanceController,
              decoration:
                  const InputDecoration(labelText: "Pharmaco-vigilance"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitData,
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                backgroundColor: const Color(0xFFED700B),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      "Ajouter le Rapport",
                      style: TextStyle(fontSize: 20, color: Color(0xFF01172D)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

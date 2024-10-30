import 'package:asermpharma/src/service/http.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajout de Prospect")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nom du prospect
            TextField(
              controller: prospectNameController,
              decoration: const InputDecoration(labelText: "Nom du prospect"),
            ),
            const SizedBox(height: 20),

            // Date
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "Date"),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),

            // Degré
            TextField(
              controller: degreeController,
              decoration: const InputDecoration(labelText: "Degré"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Objet du rendez-vous
            TextField(
              controller: rdvObjectController,
              decoration: const InputDecoration(labelText: "Objet du rdv"),
            ),
            const SizedBox(height: 20),

            // Prochain rendez-vous
            TextField(
              controller: nextRdvController,
              decoration: const InputDecoration(labelText: "Prochain rdv"),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),

            // Heure
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: "Heure"),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),

            // Contact
            TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: "Contact"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            // Ajout de fichier complémentaire
            ElevatedButton(
              onPressed: () {
                // Fonctionnalité pour ajouter un fichier
              },
              child: const Text("Ajouter un fichier complémentaire"),
            ),
            const SizedBox(height: 20),

            // Pharmaco-vigilance
            TextField(
              controller: pharmacoVigilanceController,
              decoration: const InputDecoration(labelText: "Pharmaco-vigilance"),
            ),
            const SizedBox(height: 30),

            // Bouton POST
            ElevatedButton(
              onPressed: () {
                var data = {
                  "prospectName": prospectNameController.text,
                  "date": dateController.text,
                  "degree": degreeController.text,
                  "rdvObject": rdvObjectController.text,
                  "nextRdv": nextRdvController.text,
                  "time": timeController.text,
                  "contact": contactController.text,
                  "pharmacoVigilance": pharmacoVigilanceController.text,
                };

                Http.postReporting(data);
              },
              child: const Text("POST"),
            ),
          ],
        ),
      ),
    );
  }
}

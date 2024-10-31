// ignore_for_file: use_build_context_synchronously

import 'package:asermpharma/src/service/http.dart';
import 'package:flutter/material.dart';

class POST2 extends StatefulWidget {
  const POST2({super.key});

  @override
  State<POST2> createState() => _POSTState();
}

// Contrôleurs pour chaque champ de saisie
TextEditingController entrepriseController = TextEditingController();
TextEditingController responsableController = TextEditingController();
TextEditingController telephoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController siteWebController = TextEditingController();
TextEditingController rueController = TextEditingController();
TextEditingController villeController = TextEditingController();
TextEditingController quartierController = TextEditingController();

class _POSTState extends State<POST2> {
  bool _isLoading = false; // Pour indiquer le chargement

  void _submitData() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "name": entrepriseController.text,
      "nameresponsable": responsableController.text,
      "phone": telephoneController.text,
      "email": emailController.text,
      "website": siteWebController.text,
      "rue": rueController.text,
      "ville": villeController.text,
      "quartier": quartierController.text,
      "type_customer": "Pharmacie",
    };

    try {
      final response = await Http.postPharmacy(data);

      if (response.statusCode == 200) {
        // Pharmacie créée avec succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pharmacie créée avec succès !")),
        );
      } else {
        // Erreur lors de la création de la pharmacie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Échec de la création de la pharmacie.")),
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
      appBar: AppBar(title: const Text("Ajout de Pharmacie")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: entrepriseController,
              decoration:
                  const InputDecoration(labelText: "Nom de l'entreprise"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: responsableController,
              decoration:
                  const InputDecoration(labelText: "Nom du responsable"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: telephoneController,
              decoration: const InputDecoration(labelText: "Téléphone"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: siteWebController,
              decoration: const InputDecoration(labelText: "Site web"),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: rueController,
              decoration: const InputDecoration(labelText: "Rue"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: villeController,
              decoration: const InputDecoration(labelText: "Ville"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: quartierController,
              decoration: const InputDecoration(labelText: "Quartier"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: TextEditingController(text: "Pharmacie"),
              decoration: const InputDecoration(labelText: "Type de Client"),
              readOnly: true,
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
                      "Ajouter la Pharmacie",
                      style: TextStyle(fontSize: 20, color: Color(0xFF01172D)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

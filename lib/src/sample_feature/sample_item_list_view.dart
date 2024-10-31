import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import 'sample_item_details_view_2.dart'; // Assurez-vous que ce fichier est bien importé

/// Displays a list of SampleItems.
class SampleItemListView extends StatelessWidget {
  const SampleItemListView({
    super.key,
    this.items = const [
      SampleItem(1),
      SampleItem(2)
    ], // Liste limitée à 2 éléments
  });

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          // Définition du titre en fonction de l'index
          final title = index == 0 ? 'Add Pharmacy' : 'Add Reporting';

          return ListTile(
            title: Text(title),
            leading: const CircleAvatar(
              foregroundImage: AssetImage('assets/images/logoaserm.png'),
            ),
            onTap: () {
              // Utilisation de l'index pour déterminer la navigation
              if (index == 0) {
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView2
                      .routeName, // Redirection vers SampleItemDetailsView2 pour Add Pharmacy
                );
              } else {
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView
                      .routeName, // Redirection vers SampleItemDetailsView pour Add Reporting
                );
              }
            },
          );
        },
      ),
    );
  }
}

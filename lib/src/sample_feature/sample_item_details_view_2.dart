import 'package:asermpharma/src/link/post2.dart';
import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView2 extends StatelessWidget {
  const SampleItemDetailsView2({super.key});

  static const routeName = '/sample_item2';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: POST2());
  }
}

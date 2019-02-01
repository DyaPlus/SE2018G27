import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';

class PrescriptionDetailsPage extends StatelessWidget {
  final Map<String, dynamic> prescription;

  PrescriptionDetailsPage(this.prescription);
  @override
  Widget build(BuildContext context) {
    return Page(
      title: "Prescription",
      body: Center(
        child: ListView.builder(
          itemCount: prescription.length,
          itemBuilder: (context, int i) {
            var keys = prescription.keys.toList();
            var values = prescription.values.toList();
            return Text("${keys[i]}: ${values[i]}");
          },
        ),
      ),
    );
  }
}

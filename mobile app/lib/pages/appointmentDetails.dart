import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> appointment;

  AppointmentDetailsPage(this.appointment);
  @override
  Widget build(BuildContext context) {
    return Page(
      title: "Appointment",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Appointment with Doctor ${appointment['doctor']}"),
            Text("Department: ${appointment['department']}"),
            Text("At ${appointment['time']}"),
          ],
        ),
      ),
    );
  }
}

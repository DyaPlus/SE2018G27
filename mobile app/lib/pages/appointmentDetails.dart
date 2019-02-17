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
              Text("Time: ${appointment['slot']}",
                  style: TextStyle(fontSize: 25.0)),
              Text("Doctor: ${appointment['doctor']}",
                  style: TextStyle(fontSize: 25.0)),
            ],
          ),
        ));
  }
}

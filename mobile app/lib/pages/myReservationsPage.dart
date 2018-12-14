import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';

class MyReservations extends StatelessWidget {
  final List<Map> myReservations = [];

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "My Reservations",
      hasDrawer: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/newReservation'),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: <Widget>[
          MyCard(
            icon: Icons.event_note,
            title: Text("First Reservation"),
            subtitle: Text("Dr. Omar Ahmad"),
          ),
          MyCard(
            icon: Icons.event_busy,
            title: Text("Second Appoinment"),
            subtitle: Text("Appointment Cancelled"),
          ),
          MyCard(
            icon: Icons.event_busy,
            title: Text("Second Appoinment"),
            subtitle: Text("Appointment Cancelled"),
          ),
          MyCard(
            icon: Icons.event_busy,
            title: Text("Second Appoinment"),
            subtitle: Text("Appointment Cancelled"),
          ),
          MyCard(
            icon: Icons.event_busy,
            title: Text("Second Appoinment"),
            subtitle: Text("Appointment Cancelled"),
          ),
          MyCard(
            icon: Icons.event_busy,
            title: Text("Second Appoinment"),
            subtitle: Text("Appointment Cancelled"),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

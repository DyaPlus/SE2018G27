import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'newReservationPage.dart';
import 'appointmentDetails.dart';
import 'package:intl/intl.dart';

class MyReservations extends StatefulWidget {
  final List<Map<String, dynamic>> reservations;
  MyReservations(this.reservations);

  @override
  MyReservationsState createState() {
    return MyReservationsState();
  }
}

class MyReservationsState extends State<MyReservations> {
  List<Map<String, dynamic>> myReservations = [
    {
      'doctor': 'Omar Ahmad',
      'time': DateTime(2018, 12, 31, 6, 00),
      'department': 'Dermatology',
    },
    {
      'doctor': 'Dyaa Adel',
      'time': DateTime(2019, 1, 31, 7, 00),
      'department': 'Neurology',
    },
    {
      'doctor': 'Abd El Rahman Wael',
      'time': DateTime(2019, 2, 31, 5, 30),
      'department': 'Gynecology',
    },
    {
      'doctor': 'Omar Ahmed',
      'time': DateTime(2018, 12, 29, 9, 00),
      'department': 'Gynecology',
    },
  ];

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "My Reservations",
      hasDrawer: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NewReservation(widget.reservations)),
            (Route<dynamic> route) => false),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.reservations.length,
        itemBuilder: (BuildContext context, int i) => MyCard(
              title: Text(formatter.format(widget.reservations[i]['time'])),
              subtitle: Text(widget.reservations[i]['doctor']),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AppointmentDetailsPage(widget.reservations[i]))),
              delete: () {
                setState(() {
                  widget.reservations.removeAt(i);
                });
              },
              icon: Icons.card_giftcard,
            ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

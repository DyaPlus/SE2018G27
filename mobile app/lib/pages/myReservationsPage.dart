import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hms/myWidgets.dart';
import 'newReservationPage.dart';
import 'appointmentDetails.dart';
import 'package:hms/globals.dart' as globals;

class MyReservations extends StatefulWidget {
  @override
  MyReservationsState createState() {
    return MyReservationsState();
  }
}

class MyReservationsState extends State<MyReservations> {
  List reservations = [];

  Future getReservations() async {
    var res = await http.get(
      globals.domain + "users/queryres/",
      headers: globals.tokenHeader,
    );

    if (res.statusCode == 200) {
      reservations = json.decode(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "My Reservations",
      hasDrawer: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewReservation()),
            ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: getReservations(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (reservations.isNotEmpty) {
              return ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (BuildContext context, int i) => MyCard(
                      title: Text("${reservations[i]['slot']}"),
                      subtitle: Text("${reservations[i]['doctor']}"),
                      icon: Icons.book,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AppointmentDetailsPage(reservations[i]))),
                    ),
              );
            } else {
              return Center(child: Text("No reservations"));
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        },
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

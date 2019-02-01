import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hms/myWidgets.dart';
import 'newReservationPage.dart';
import 'appointmentDetails.dart';
import 'package:intl/intl.dart';

class MyReservations extends StatefulWidget {
  @override
  MyReservationsState createState() {
    return MyReservationsState();
  }
}

class MyReservationsState extends State<MyReservations> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future getReservations() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/users/");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "My Reservations",
      hasDrawer: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NewReservation()),
            (Route<dynamic> route) => false),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: getReservations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) => MyCard(
                    delete: () {},
                    title: Text("${snapshot.data[i]['name']}"),
                    subtitle: Text(""),
                    icon: Icons.book,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AppointmentDetailsPage(snapshot.data[i]))),
                  ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      /*
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
      */
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

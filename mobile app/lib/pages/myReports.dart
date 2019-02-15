import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'reportDetails.dart';

import 'package:hms/myWidgets.dart';
import 'newReservationPage.dart';
import 'appointmentDetails.dart';
import 'package:intl/intl.dart';
import 'package:hms/globals.dart' as globals;

class MyReports extends StatefulWidget {
  @override
  MyReportsState createState() {
    return MyReportsState();
  }
}

class MyReportsState extends State<MyReports> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<Map<String, dynamic>> myReports = [];
  Future getReports() async {
    var res = await http.get(
      globals.domain + "users/queryres/",
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(res.body);
    print(res.statusCode);
    print(resBody);
    if (res.statusCode == 200) {
      setState(() {
        myReports = resBody;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "My Reports",
      hasDrawer: true,

      body: FutureBuilder(
        future: getReports(),
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
                        reportDetailsPage(snapshot.data[i]))),
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

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
  List myReports = [];

  Future getReports() async {
    var res = await http.get(
      globals.domain + "users/getreportdetails/0/",
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(res.body);

    print(res.statusCode);
    print(resBody);

    if (res.statusCode == 200) {
      myReports = resBody;
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
          print(snapshot);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (myReports.length == 0) {
              return Center(
                child: Text("No reports"),
              );
            }
            return ListView.builder(
              itemCount: myReports.length,
              itemBuilder: (BuildContext context, int i) => MyCard(
                    title: Text("${myReports[i]['title']}"),
                    subtitle: Text("${myReports[i]['content']}"),
                    icon: Icons.book,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReportDetailsPage(myReports[i]))),
                  ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
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

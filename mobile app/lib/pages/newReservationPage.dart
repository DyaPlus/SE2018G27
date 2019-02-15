import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'myReservationsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hms/globals.dart' as globals;

class NewReservation extends StatefulWidget {
  @override
  NewReservationState createState() {
    return NewReservationState();
  }
}

class NewReservationState extends State<NewReservation> {
  final Map<String, dynamic> newReservation = {
    'doctor': null,
    'slot_id': null,
  };

  List doctors = [
    {
      'id': 0,
      'username': "waiting...",
    }
  ];

  List slots = [
    {
      'id': 0,
      'time': 'waiting...',
    }
  ];

  Future getDoctors() async {
    var res = await http.get(
      globals.domain + "users/docs/",
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(utf8.decode(res.bodyBytes));

    if (res.statusCode == 200) {
      doctors = resBody;
    }
  }

  Future querySlot(String doc) async {
    var docID = '0';

    for (var doctor in doctors) {
      if (doctor['full_name'] == doc) {
        docID = doctor['id'].toString();
        break;
      }
    }

    http.Response res = await http.get(
      globals.domain + 'users/queryslot/$docID',
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(res.body);

    print(res.statusCode);
    print(resBody);

    if (res.statusCode == 200) {
      slots = resBody;
    } else if (resBody['errors'] == 'No Slots Available') {
      slots[0]['time'] = ['No slots available'];
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Error"),
          content: Text("No Slots Available"),
        ),
      );
    }
    print(slots);
  }

  Future sendReservation() async {
    print(newReservation);
    http.Response response = await http.post(
      globals.domain + 'users/reserveslot/',
      headers: globals.tokenHeader,
      body: newReservation,
    );
    print(response.statusCode);
    print(response.body);

    return null;
  }

  void showAlert(BuildContext context) {
    if (newReservation['slot_id'] != null)
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("New Reservation"),
                content: Text(
                    '${newReservation['doctor']}: ${newReservation['slot_id']} ?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      sendReservation();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyReservations()),
                          (Route<dynamic> route) => false);
                      //Navigator.pop(context);
                    },
                  )
                ],
              ));
    else
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Error"),
              content: Text('Information not complete'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "New Reservation",
      hasDrawer: true,
      body: FutureBuilder(
        future: getDoctors(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MyDropDown(
                    title: "Doctors",
                    items:
                        doctors.map((doctor) => doctor['full_name']).toList(),
                    onChanged: (value) => querySlot(value),
                  ),
                  MyDropDown(
                    title: "Slots",
                    items: slots.map((slot) => slot['time']).toList(),
                    onChanged: (value) {
                      slots.forEach((slot) {
                        if (slot['time'] == value) {
                          newReservation['slot_id'] = slot['id'].toString();
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error);
          }
        },
      ),
      bottomNavigationBar: MyBottomAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5.0,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("New Reservation"),
        onPressed: () {
          showAlert(context);
        },
      ),
    );
  }
}

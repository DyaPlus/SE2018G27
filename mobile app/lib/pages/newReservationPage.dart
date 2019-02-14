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
    'slot': null,
  };

  List doctors = [
    {'id': 0, 'username': " "},
  ];

  Future getDoctors() async {
    var res = await http.get(globals.domain + "users/docs/");
    var resBody = json.decode(res.body);

    setState(() {
      doctors = resBody;
    });
  }

  Future querySlot() async {

    var docId;
    doctors.forEach((doc){
      if (doc['username'] == newReservation['doctor']){
        docId = doc['id'];
      }
    });

    http.Response response = await http.get(
      globals.domain + 'users/queryslot/$docId',
      headers: globals.tokenHeader,
    );
    print(response.statusCode);
    print(response.body);
  }

  Future sendReservation() async {
    print(newReservation);
    http.Response response = await http.post(
      globals.domain + 'users/reserveslot/',
      headers: globals.tokenHeader,
      body: newReservation,
    );
    print(globals.tokenHeader);
    print(response.statusCode);
    print(response.body);
  }

  void showAlert(BuildContext context) {
    if (newReservation['doctor'] != null && newReservation['slot'] != null)
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("New Reservation"),
                content: Text('Reserve?'),
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
  void initState() {
    super.initState();
    this.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      hasDrawer: true,
      title: "New Reservation",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyDropDown(
              title: "Doctors",
              items: doctors.map((doctor) => doctor['username']).toList(),
              onChanged: (value) => newReservation['doctor'] = value,
            ),
            MyRoundedButton(
              text: "Select slot",
              onPressed: () async {
                newReservation['slot'] = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2020),
                  initialDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.day,
                );
                TimeOfDay time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                newReservation['slot'] = newReservation['slot']
                    .add(Duration(hours: time.hour, minutes: time.minute));

                newReservation['slot'] = newReservation['slot'].toString();
                querySlot();
              },
            ),
          ],
        ),
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

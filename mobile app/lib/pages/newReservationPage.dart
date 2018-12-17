import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'myReservationsPage.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class NewReservation extends StatelessWidget {
  final List<Map<String, dynamic>> reservations;
  NewReservation(this.reservations);

  final Map<String, dynamic> newReservation = {
    'doctor': null,
    'time': null,
    'department': null,
  };

  void showAlert(BuildContext context) {
    if (newReservation['doctor'] != null &&
        newReservation['department'] != null &&
        newReservation['time'] != null)
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
                      reservations.add(newReservation);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyReservations(reservations)),
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
      hasDrawer: true,
      title: "New Reservation",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyDropDown(
              title: "Department",
              onChanged: (value) => newReservation['department'] = value,
              items: [
                "Dermatology",
                "Neurology",
                "Gynecology",
              ],
            ),
            MyDropDown(
              title: "Doctor",
              onChanged: (value) => newReservation['doctor'] = value,
              items: [
                "Dyaa Adel",
                "Abd El Rahman Helaly",
                "Omar Ahmed",
              ],
            ),
            MyRoundedButton(
              text: "Select Date and time",
              onPressed: () async {
                print(newReservation['time']);
                newReservation['time'] = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2020),
                  initialDate: DateTime.now(),
                  initialDatePickerMode: DatePickerMode.day,
                );
                print(newReservation['time']);
                TimeOfDay time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                newReservation['time'] = newReservation['time']
                    .add(Duration(hours: time.hour, minutes: time.minute));
                print(newReservation['time']);
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
        onPressed: () => showAlert(context),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

class NewReservation extends StatelessWidget {
  // void _getAPI() async {
  //   var url = "https://jsonplaceholder.typicode.com/todos/1";
  //   http.get(url).then((http.Response response) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     print(responseData);
  //   });
  // }

  void showAlert(BuildContext context) {
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
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
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
              items: [
                "Dermatology",
                "Neurology",
                "Gynecology",
              ],
            ),
            MyDropDown(
              title: "Doctor",
              items: ["Doctor Dyaa", "Doctor Helaly", "Doctor Omar"],
            ),
            MyRoundedButton(
              text: "Select Date",
              onPressed: () => showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2020),
                    initialDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.day,
                  ),
            ),
            MyRoundedButton(
              text: "Select Time",
              onPressed: () => showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ),
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

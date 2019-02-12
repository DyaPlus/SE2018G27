import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'myReservationsPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewReservation extends StatefulWidget {
  @override
  NewReservationState createState() {
    return NewReservationState();
  }
}

class NewReservationState extends State<NewReservation> {
  final String url = "";

  final Map<String, dynamic> newReservation = {
    'doctor': null,
    'time': null,
    'department': null,
  };

  List doctors = List();

  Future<String> getDoctors() async {
    var res = await http.get(Uri.encodeFull(
        "https://secret-lowlands-85631.herokuapp.com/users/docs/"));
    var resBody = json.decode(res.body);

    setState(() {
      doctors = resBody;
    });

    return "Sucess";
  }

  // Future<String> getDoctors() async {
  //   final response = await http
  //       .get("https://secret-lowlands-85631.herokuapp.com/users/docs/");

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       doctors = json.decode(response.body);
  //     });
  //     return "SUCCESS";
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

  Future sendReservation() {
    print(newReservation);
    //return http.post(url, body: json.encode(newReservation));
    return http.post(url, body: newReservation);
  }

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
            FutureBuilder(
              future: getDoctors(),
              initialData: doctors,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    return Text('Result: ${snapshot.data}');
                }
                return null;

                if (snapshot.hasData) {
                  print(snapshot.data);
                  return MyDropDown(
                    title: "Doctor",
                    onChanged: (value) => newReservation['doctor'] = value,
                    items: [],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return Container();
                }
              },
            ),
            // DropdownButton(
            //     onChanged: (value) {
            //       print(doctors);
            //       print(value);
            //     },
            //     items: doctors
            //         .map((item) => DropdownMenuItem(
            //               value: item['name'],
            //               child: Text('name'),
            //             ))
            //         .toList()),
            // MyDropDown(
            //   title: "Doctor",
            //   onChanged: (value) => newReservation['doctor'] = value,
            //   items: doctors,
            //),
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
                TimeOfDay time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                newReservation['time'] = newReservation['time']
                    .add(Duration(hours: time.hour, minutes: time.minute));
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

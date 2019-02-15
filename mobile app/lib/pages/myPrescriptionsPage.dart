import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'prescriptionDetails.dart';
import 'package:hms/globals.dart' as globals;

class MyPrescriptions extends StatefulWidget {
  @override
  MyPrescriptionsState createState() {
    return MyPrescriptionsState();
  }
}

class MyPrescriptionsState extends State<MyPrescriptions> {
  List<Map<String, dynamic>> myPrescriptions = [];

  Future getPresctiptions() async {
    var res = await http.get(
      globals.domain + "users/queryres/",
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(res.body);
    print(res.statusCode);
    print(resBody);
    if (res.statusCode == 200) {
      setState(() {
        myPrescriptions = resBody;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: "My Prescriptions",
      hasDrawer: true,
      body: FutureBuilder(
        future: getPresctiptions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) => MyCard(
                    title: Text("${snapshot.data[i]['name']}"),
                    subtitle: Text(""),
                    icon: Icons.book,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PrescriptionDetailsPage(snapshot.data[i]))),
                  ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

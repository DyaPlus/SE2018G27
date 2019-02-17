import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart' as PDF;

import 'package:hms/myWidgets.dart';
import 'package:hms/globals.dart' as globals;

class MyReports extends StatefulWidget {
  @override
  MyReportsState createState() {
    return MyReportsState();
  }
}

class MyReportsState extends State<MyReports> {
  List myReports = [];

  Future getReports() async {
    var res = await http.get(
      globals.domain + "users/getreportdetails/0/",
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(res.body);

    if (res.statusCode == 200) {
      myReports = resBody;
    }
  }

  Future viewPDF(var reportID) async {
    http.Response response = await http.get(
        globals.domain + 'users/getreportpdf/0/$reportID/',
        headers: globals.tokenHeader);

    PDF.PdfViewer.loadBytes(response.bodyBytes);
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
                    onTap: () => viewPDF(myReports[i]['id']),
                  ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        },
      ),
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

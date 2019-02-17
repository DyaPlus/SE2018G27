import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart' as PDF;

import 'package:hms/myWidgets.dart';
import 'package:hms/globals.dart' as globals;

class ReportDetailsPage extends StatelessWidget {
  final Map<String, dynamic> report;
  DateTime date;
  String dateConverted;

  ReportDetailsPage(this.report) {
    date = DateTime.parse(report['created_at']);
    dateConverted = "${date.year}-${date.month}-${date.day}\n${date.hour}:${date.minute}:${date.second}";
  }

  Future viewPDF() async {
    http.Response response = await http.get(
        globals.domain + 'users/getreportpdf/0/${report['id']}',
        headers: globals.tokenHeader);

    PDF.PdfViewer.loadBytes(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Page(
      title: report['title'] == 'A'
          ? "Analysis"
          : report['title'] == 'E'
              ? "Examination"
              : report['title'] == 'R' ? "Rays" : "Error",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Created at:\n$dateConverted", style: TextStyle(fontSize: 25.0)),
            Text("${report['content']}", style: TextStyle(fontSize: 25.0)),
            RaisedButton(
              child: Text("Get PDF"),
              onPressed: viewPDF,
            ),
          ],
        ),
      ),
    );
  }
}

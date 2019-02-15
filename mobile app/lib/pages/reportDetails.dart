import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';

class ReportDetailsPage extends StatelessWidget {
  final Map<String, dynamic> report;

  ReportDetailsPage(this.report);
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
            Text("Created at: ${report['created_at']}",
                style: TextStyle(fontSize: 25.0)),
            Text("${report['content']}", style: TextStyle(fontSize: 25.0)),
          ],
        ),
      ),
    );
  }
}

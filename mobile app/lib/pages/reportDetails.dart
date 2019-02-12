import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';

class reportDetailsPage extends StatelessWidget {
  final Map<String, dynamic> report;

  reportDetailsPage(this.report);
  @override
  Widget build(BuildContext context) {
    return Page(
      title: "report",
      body: Center(
        child: ListView.builder(
          itemCount: report.length,
          itemBuilder: (context, int i) {
            var keys = report.keys.toList();
            var values = report.values.toList();
            return Text("${keys[i]}: ${values[i]}");
          },
        ),
      ),
    );
  }
}

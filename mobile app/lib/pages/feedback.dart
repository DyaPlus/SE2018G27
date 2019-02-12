import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hms/pages/mainHomePage.dart';

class NewFeedback extends StatefulWidget {
  @override
  NewFeedBackState createState() {
    return NewFeedBackState();
  }
}

class NewFeedBackState extends State<NewFeedback> {
  String feedback = "";

  void sendFeedback() {
    Map<String, String> enteredFeedback = {
      'feedback': '',
    };
    String url = '';
    var enteredFeedbackJSON = json.encode(enteredFeedback);
    http.post(url, body: enteredFeedbackJSON);
  }

  void showAlert(BuildContext context) {
    if (feedback != "")
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text("Send Feedback"),
                content: Text('Send?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text("Yes"),
                    onPressed: () {
                      sendFeedback();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainHomePage(name: "omar")),
                          (Route<dynamic> route) => false);
                    },
                  )
                ],
              ));
    else
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Error"),
              content: Text("Feedback can't be empty"),
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
      title: "New feedback",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Input(
              text: "Write your feedback",
              onChanged: (value) {
                setState(() {
                  feedback = value;
                });
                print(feedback);
              },
              // onChanged: (value) => widget.feedback = value,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5.0,
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("send feedback"),
        onPressed: () {
          print(feedback);
          showAlert(context);
        },
      ),
    );
  }
}

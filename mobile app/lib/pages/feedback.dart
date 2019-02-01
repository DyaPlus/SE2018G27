import 'package:flutter/material.dart';
import 'package:hms/myWidgets.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hms/pages/mainHomePage.dart';

class NewFeedback extends StatefulWidget {

  var feedback = "";

  void sendFeedback() {
    var url = '';
    http.post(url, body: feedback);
  }
  @override
  NewFeedBackState createState() {
    return NewFeedBackState();
  }
}

class NewFeedBackState extends State<NewFeedback> {
  void showAlert(BuildContext context) {
    if (widget.feedback != "")
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("send feedback"),
            content: Text('send?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  widget.sendFeedback();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MainHomePage(name: "omar")),
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
      title: "New feedback",
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Input(
              text: "write your feedback",
              onChanged: (value) {
                setState(() {
                  widget.feedback = value;
                });
                print(widget.feedback);
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
          print(widget.feedback);
          showAlert(context);
        },
      ),
    );
  }
}

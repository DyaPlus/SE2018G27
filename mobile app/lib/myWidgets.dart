import 'package:flutter/material.dart';
import 'pages/myReservationsPage.dart';
import 'pages/feedback.dart';
import 'pages/myPrescriptionsPage.dart';
import 'pages/myReports.dart';
import 'pages/mainHomePage.dart';

class Page extends StatelessWidget {
  Page({
    @required this.title,
    @required this.body,
    this.userName = '',
    this.hasDrawer = false,
    this.centerTitle = false,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String title;
  final Widget body;
  final bool hasDrawer;
  final bool centerTitle;
  final FloatingActionButton floatingActionButton;
  final Widget bottomNavigationBar;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: centerTitle,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: hasDrawer
          ? Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Center(
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyReservations()),
                        (Route<dynamic> route) => false),
                    title: Text("My Reservations"),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => NewFeedback()),
                        (Route<dynamic> route) => false),
                    title: Text("Feedback"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPrescriptions()),
                          (Route<dynamic> route) => false);
                    },
                    title: Text("Prescriptions"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyReports()),
                              (Route<dynamic> route) => false);
                    },
                    title: Text("Reports"),
                  ),
                  Divider(color: Colors.redAccent), 
                  ListTile(
                    leading: RotatedBox(
                        quarterTurns: 2, child: Icon(Icons.exit_to_app)),
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context, '/firstHome', (Route<dynamic> route) => false),
                    title: Text("Logout"),
                  ),
                ],
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          (floatingActionButton != null) ? floatingActionButton : null,
      bottomNavigationBar:
          (bottomNavigationBar != null) ? bottomNavigationBar : null,
      body: body,
    );
  }
}

class MyCard extends StatelessWidget {
  final IconData icon;
  final Text title;
  final Text subtitle;
  final Function onTap;
  final Function delete;

  MyCard({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.onTap,
    @required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      child: InkWell(
        //splashColor: Colors.lightBlueAccent,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(icon),
              title: title,
              subtitle: subtitle,
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.white,
                          ),
                        ),
                        Center(
                          child: Text(
                            "DELETE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    onPressed: delete,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String text;
  final TextInputType type;
  final int maxLength;
  final bool password;
  final String label;
  final IconData icon;
  final double padding;
  final Function onChanged;
  final ColorSwatch color;

  Input(
      {this.type = TextInputType.text,
      @required this.text,
      this.maxLength,
      this.icon,
      this.padding = 0.0,
      this.password = false,
      @required this.onChanged,
      this.label,
      this.color});

  final String value = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(3.0),
            child: Text(
              text + ":",
              style: TextStyle(fontSize: 15.0, color: color),
            ),
          ),
          Container(
            padding: EdgeInsets.all(3.0),
            width: 300.0,
            child: TextField(
              obscureText: password,
              decoration: InputDecoration(
                labelText: label,
                icon: Icon(icon),
              ),
              maxLength: maxLength,
              keyboardType: type,
              textInputAction: TextInputAction.next,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final route;
  final String text;
  final num padding;
  final num width, height;
  final Color color;
  final Color splashColor;

  MyButton({
    @required this.text,
    @required this.route,
    this.width = 100.0,
    this.height = 50.0,
    this.padding = 0.0,
    this.color = Colors.lightBlue,
    this.splashColor = Colors.lightBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        color: Colors.tealAccent,
        height: height,
        width: width,
        child: Material(
          color: color,
          child: InkWell(
              splashColor: splashColor,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: () => Navigator.pushNamed(context, route)
              //onTap: () => Navigator.of(context)
              //    .push(MaterialPageRoute(builder: (context) => navigateTo)),
              ),
        ),
      ),
    );
  }
}

class MyBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Builder(
        builder: (BuildContext context) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          );
        },
      ),
    );
  }
}

class MyDropDown extends StatefulWidget {
  final String title;
  final List<String> items;
  final Function(dynamic) onChanged;

  MyDropDown({
    @required this.title,
    @required this.items,
    @required this.onChanged,
  });

  @override
  MyDropDownState createState() {
    return MyDropDownState();
  }
}

class MyDropDownState extends State<MyDropDown> {
  String _currentValue; //= widget.items[0];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(widget.title, style: TextStyle(fontSize: 25.0)),
        ),
        DropdownButton(
          value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
            widget.onChanged(value);
          }, //widget.onChanged(value),
          items: widget.items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class MyRoundedButton extends StatelessWidget {
  final String text;
  final ColorSwatch color;
  final ColorSwatch highlightColor;
  final Function onPressed;

  MyRoundedButton({
    @required this.onPressed,
    @required this.text,
    this.color = Colors.lightBlue,
    this.highlightColor = Colors.lightBlueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: color),
      highlightedBorderColor: highlightColor,
      child: Text(text),
      color: Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}

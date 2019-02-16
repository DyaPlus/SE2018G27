// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:hms/myWidgets.dart';
// import 'prescriptionDetails.dart';
// import 'package:hms/globals.dart' as globals;

// import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

// class MyPrescriptions extends StatefulWidget {
//   @override
//   MyPrescriptionsState createState() {
//     return MyPrescriptionsState();
//   }
// }

// class MyPrescriptionsState extends State<MyPrescriptions> {
//  // List<Map<String, dynamic>> myPrescriptions = [];
// String myPrescriptions = "waittt";
 
//  initial() async {
//     var res = await http.get(
//       globals.domain + "users/getreportdetails/0/",
//       headers: globals.tokenHeader,
//     );

//     var resBody = await json.decode(res.body);
//    // print(res.statusCode);
//     print(resBody);
//     //if (res.statusCode == 200) {
//     //  setState(() {
//         myPrescriptions =  resBody.toString();
//     //  });
//    // }


//    // return resBody ;
//   } 
//  @override
//   void initState()  {
//     initial() ;
//      return super.initState();
//   }

 
 
 
 
 
 
 
 
 
//   Future getPresctiptions() async {
//     var res = await http.get(
//       globals.domain + "users/getreportdetails/",
//       headers: globals.tokenHeader,
//     );

//     var resBody = json.decode(res.body);
//    // print(res.statusCode);
//     print(resBody);
//     if (res.statusCode == 200) {
//       setState(() {
//         myPrescriptions = resBody.toString();
//       });
//     }


//    // return resBody ;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Page(
//       title: "My Prescriptions",
//       hasDrawer: true,
//       body:
//       Text(myPrescriptions)
//       /*
      
//        FutureBuilder(
//         future: getPresctiptions(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
         
//           // return  WebView(
//           //                         initialUrl:Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName("UTF-8")).toString(), // maybe you Uri.dataFromString(snapshot.data, mimeType: 'text/html', encoding: Encoding.getByName("UTF-8")).toString()
//           //                         javascriptMode: JavascriptMode.unrestricted,
//           //                       );
         
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int i) => MyCard(
//                     title: Text("${snapshot.data[i]['name']}"),
//                     subtitle: Text(""),
//                     icon: Icons.book,
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) =>
//                             PrescriptionDetailsPage(snapshot.data[i]))),
//                   ),
//             ); 
//           } else if (snapshot.hasError) {
//             return Text("${snapshot.error}");
//           }

//           return Center(child: CircularProgressIndicator());
//         },
//        ), */
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'reportDetails.dart';

import 'package:hms/myWidgets.dart';
import 'newReservationPage.dart';
import 'appointmentDetails.dart';
import 'package:intl/intl.dart';
import 'package:hms/globals.dart' as globals;

class MyPrescriptions extends StatefulWidget {
  @override
  MyPrescriptionsState createState() {
    return MyPrescriptionsState();
  }
}

class MyPrescriptionsState extends State<MyPrescriptions> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List myReports = [];

  Future getReports() async {
    var res = await http.get(
      globals.domain + "users/getreportdetails/0/",
      headers: globals.tokenHeader,
    );

    var resBody = json.decode(res.body);

    print(res.statusCode);
    print(resBody);

    if (res.statusCode == 200) {
      myReports = resBody;
    }
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReportDetailsPage(myReports[i]))),
                  ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        },
      ),
      /*
      body: ListView.builder(
        itemCount: widget.reservations.length,
        itemBuilder: (BuildContext context, int i) => MyCard(
              title: Text(formatter.format(widget.reservations[i]['time'])),
              subtitle: Text(widget.reservations[i]['doctor']),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AppointmentDetailsPage(widget.reservations[i]))),
              delete: () {
                setState(() {
                  widget.reservations.removeAt(i);
                });
              },
              icon: Icons.card_giftcard,
            ),
      ),
      */
      bottomNavigationBar: MyBottomAppBar(),
    );
  }
}

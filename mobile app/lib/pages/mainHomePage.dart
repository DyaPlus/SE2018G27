import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:async';
import '../myWidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:hms/globals.dart' as globals;



// class MainHomePage extends StatelessWidget {
//   final String name;
//   MainHomePage({@required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Page(
//       userName: name,
//       title: "Home Page",
//       centerTitle: true,
//       hasDrawer: true,
//       body: Center(
//         child: Text(
//           "Welcome " + name,
//           style: TextStyle(fontSize: 30.0),
//         ),
//       ),
//     );
//   }
// }

class MainHomePage extends StatefulWidget {
  MainHomePage({ name});
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

////////////////variables////////////
DateTime _DOB = DateTime.now();
String _id =   "please wait";
String _name = "please wait" ;
String _phone = "please wait" ;
String _type = "please wait" ;

var url = globals.domain + "users/profile/";
List data = [];
  final nacontr = TextEditingController(text: "please wait") ;
  final idcontr = TextEditingController(text: "please wait") ;
  final phcontr = TextEditingController(text: "please wait") ;
  final typecontr = TextEditingController(text: "please wait") ;

 /////////////////functions /////////////////////
// httpget(String url , String field) async{
//var a = await  http.get(url);
//var b = convert.jsonDecode(a.body) ;
//print(b);
//print(url);
//return b[field] ;
//}






initial () async{
  var res = await http.get(
    url,
    headers: globals.tokenHeader,
  );

  var resBody = json.decode(res.body);
  print(res.statusCode);
  print(resBody);
int t = await resBody['id'];
_id = "$t";
idcontr.text = _id ;

_name = await resBody['full_name'];
nacontr.text = _name;

_phone = await (resBody['mobile']);
phcontr.text =_phone ;

_type = await resBody['type'];
typecontr.text = _type ;

}

/////////////////////////////////////
//////////////////
///


/////////////////////////donot open again////////////////////////////
 @override
  void initState()  {
    initial() ;
     return super.initState();
  }


@override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    idcontr.dispose();
    super.dispose(); 
  }
//////////////////////////////////////////

//////////////////


void _save () {


var url = globals.domain+"profile/" ;
http.post(url, body: {"name" :nacontr.text , "birth" : _DOB , "type": typecontr.text
, "phone": phcontr.text , "id": idcontr.text}) ;


  setState(() {_id = idcontr.text ; _name= nacontr.text ;_type = typecontr.text ;
  _phone = phcontr.text ; });

}

/////////////////////////////

  Future _changeDOB() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: _DOB,
        firstDate: DateTime(1000),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);

    if (picked != null) {
      _DOB =picked ; //await _save() ;
      setState(() {});
  } 
  }
////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Page(
         title: "PROFILE",
      centerTitle: true,
       hasDrawer: true,
      body: Container(
        child: ListView(children: <Widget>[
          Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: Text("Full name",
                              style: TextStyle(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Material(
                        child: TextFormField(
                           onEditingComplete: ()=> _save() ,
                          textInputAction: TextInputAction.done,
                         controller: nacontr,
                         
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: Material(
                        child: Text("Date Of Birth",
                            style: TextStyle(
                              color: Colors.green,
                            )),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Material( 
                        child: GestureDetector( 
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Container(
                         //  width: 200,
                          child: Text(  
                            _DOB.year.toString() +
                                "-" +
                                _DOB.month.toString() +
                                "-" +
                                _DOB.day.toString() , style:  TextStyle(fontSize: 12),
                          ),
                        )
                        ,
                      ),
                      onTap: () => _changeDOB(),
                    )),
                  ),
              Flexible(
                child: Container ( 
                color: Colors.green ,
        height: 50,
        width: 50,
                    child: Material(child: InkWell( child:Center(child: Text("save" , style: TextStyle(color: Colors.orange),)) ,splashColor: Colors.red ,onTap: ()=>_save(),)
                
                ) 
                
                ),
              )
                ],
              ),
            ),
           
           



Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: Text("id",
                              style: TextStyle(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Material(
                        child: TextFormField(
                          controller: idcontr,
                          textInputAction: TextInputAction.done,
                        
                          onEditingComplete: ()=> _save() ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),





Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: Text("PHONE",
                              style: TextStyle(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Material(
                        child: TextFormField(
                          controller: phcontr,
                          textInputAction: TextInputAction.done,
                        
                          onEditingComplete: ()=> _save() ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              

Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: Text("TYPE",
                              style: TextStyle(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Material(
                        child: TextFormField(
                          controller: typecontr,
                          textInputAction: TextInputAction.done,
                        
                          onEditingComplete: ()=> _save() ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ]),
       
       
       ]),
      ),
    );
  }
}

import 'package:bc_app/views/revendeur/beASeller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactingService{

  BeASeller bs = new BeASeller();

  bool isSent;

  /// call BC
  Future<void> callSAV(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خدمة البائعين', textDirection: TextDirection.rtl),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('الاتصال بنا', textDirection: TextDirection.rtl),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('اجراء المكالمة', textDirection: TextDirection.rtl),
              onPressed: () {
                FlutterPhoneDirectCaller.callNumber('121');
              },
            ),
            FlatButton(
              child: Text('غلق', textDirection: TextDirection.rtl),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }


  /// Send mail to BC
  Future<http.Response> mail(username, telephone, email) async{

    String myUrl = 'https://bc.meks.ma/BC/v1/mail/';

    String username = 'TelcoBill_Api_User_V2|1|6';
    String password = '4398eefebc6342f42cd25e93250484fe76e19427bccc9c3d538a4c02faa267e81a6e4cdcb9ff10d90ef809fe2426d28cac87c2a314a9913aed56b64f687e616f';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var data;
    isSent = false;
    http.post(Uri.parse(myUrl),
      headers: { 'Accept': 'Application/json', 'authorization': basicAuth},
      body: json.encode({
        "username": "$username",
        "tel": "$telephone",
        "email": "$email"
      }),
    ).then((value){
      data = value.body;
      isSent = true;
    });
    return data;
  }

}
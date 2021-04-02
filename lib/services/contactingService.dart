
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContactingService{

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
}
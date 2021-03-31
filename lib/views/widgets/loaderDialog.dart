import 'package:flutter/material.dart';

class LoaderDialog {

  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
    var wid = MediaQuery.of(context).size.width / 2;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 20 , right: 20),
          child: Dialog(
              key: key,
              backgroundColor: Colors.white,
              child: Container(
                width: 200.0,
                height: 200.0,
                child:  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10.0),
                      Text(
                          'جاري الاتصال',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      )
                    ],
                  ),
                )
              )
          ),
        );
      },
    );
  }
}
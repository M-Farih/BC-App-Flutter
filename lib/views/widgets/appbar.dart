import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //  margin: const EdgeInsets.only(right: 75),
            child: Image.asset(
              'images/logo-appbar.png',
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                color: Colors.black54,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 26,
                  width: 1,
                  color: Colors.black54,
                ),
              ),
              GestureDetector(
                onTap: () => _disconnect(context),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.settings_power,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          )
        ],
      ),

    );
  }
  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

Future<void> _disconnect(context) async {
  print('disc clicked');
  AuthentificationService authService = new AuthentificationService();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تسجيل الخروج', textDirection: TextDirection.rtl,),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('هل انت متاكد', textDirection: TextDirection.rtl),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('تسجيل الخروج'),
            onPressed: () {
              authService.disconnect();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('تسجيل الخروج')));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => LoginPage()));
            },
          ),
          FlatButton(
            child: Text('غلق'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}




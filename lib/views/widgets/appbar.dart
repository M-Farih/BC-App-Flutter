import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/_revendeur/profil/profilPage.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSeller;
  final int roleId;

  const MyAppBar({Key key, this.isSeller, this.roleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ///logo
          Container(
            //  margin: const EdgeInsets.only(right: 75),
            child: Image.asset(
              'assets/images/logo-appbar.png',
              height: 30,
            ),
          ),

          ///notification & disconnection
          Row(
            children: [
              /// profile
              isSeller
                  ?GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfilePage()
                  ));
                },
                child: Container(
                  width: 45,
                  height: 45,
                  color: Colors.transparent,
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.black54,
                  ),
                ),
              )
                  :SizedBox(),

              /// Disconnect
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 26,
                  width: 1,
                  color: Colors.black54,
                ),
              ),
              GestureDetector(
                onTap: () => _disconnect(context, roleId),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.settings_power,
                      color: Colors.black54,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      leadingWidth: 0,
      leading: Container(),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

Future<void> _disconnect(context, int roleId) async {
  var authProvider = Provider.of<AuthProvider>(context, listen: false);
  var userProvider = Provider.of<UserProvider>(context, listen: false);
  print('disc clicked');
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          roleId == 3?'تسجيل الخروج': 'Déconnexion',
          textDirection: TextDirection.rtl,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(roleId == 3?'هل أنت متأكد؟' : '?Êtes-vous sûr', textDirection: TextDirection.rtl),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(roleId == 3? 'تسجيل الخروج' :'Déconnexion', style: TextStyle(color: Colors.red),),
            onPressed: () {
              FirebaseMessaging.instance.unsubscribeFromTopic("admin").then((value) {
                print('admin unsubscribed!!');
              });
              FirebaseMessaging.instance.unsubscribeFromTopic("users").then((value) {
                print('users unsubscribed!!');
              });
              FirebaseMessaging.instance.unsubscribeFromTopic("revendeurs").then((value) {
                print('revendeur unsubscribed!!');
              });
              authProvider.logout().whenComplete(() {
                userProvider.sellers.clear();
              });
              if(roleId == 3){
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('تسجيل الخروج')));
              }else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Déconnexion')));
              }
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            },
          ),
          FlatButton(
            child: Text(roleId == 3?'غلق':'Fermer'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

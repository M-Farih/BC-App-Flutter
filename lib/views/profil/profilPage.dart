import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/views/profil/profilDetails.dart';
import 'package:flutter/material.dart';

import '../authentification/loginPage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115.0,
          width: 115.0,
          child: Stack(
            fit: StackFit.expand,
            children:[
              CircleAvatar(
                backgroundImage: AssetImage('images/profil.jpg'),
              ),
              Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide(color: Colors.white)
                    ),
                    color: Color(0xFFF5F6F9),
                    onPressed: (){},
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              )
            ]
            ),
          ),
        SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: FlatButton(
            padding: EdgeInsets.all(20.0),
            color: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfilDetails(
                      fname: "Othmane", lname: "Es-sayeh", userName: "othmaneess", password: "123456",
                    )));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 30.0,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(height: 20),
                  Expanded(child: Text(
                    'Mon compte'
                  )),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.0,
                  )
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: (){
                print('disconnected clicked!!!!');
                _disconnect(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    size: 30.0,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(height: 20),
                  Expanded(child: Text(
                      'Se deconnecter'
                  )),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.0,
                  )
                ],
              )),
        )
      ],
    );
  }
}

void _showuserdata (){
  AuthentificationService authService = new AuthentificationService();
  authService.getUserinfo();
}

Future<void> _disconnect(context) async {
  AuthentificationService authService = new AuthentificationService();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Déconnexion'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Voulez-vous vraiment vous déconnecter de l\'application?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Se deconnecter'),
            onPressed: () {
              authService.disconnect();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Déconnexion')));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => LoginPage()));
            },
          ),
          FlatButton(
            child: Text('Fermer'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
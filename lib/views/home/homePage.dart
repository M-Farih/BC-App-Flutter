import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/services/productService.dart';
import 'package:bc_app/views/profil/profilPage.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dashboard/dashboard.dart';

import 'package:bc_app/views/widgets/productCard.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthentificationService authService = new AuthentificationService();

  int _currentIndex = 0;

  final tabs = [
    Dashboard(),
    FutureBuilder(
        future: ProductService.fillProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return ProductCard(
                    name: snapshot.data[index].p_title,
                    price: snapshot.data[index].p_price,
                    imgPath: snapshot.data[index].p_image,
                    desc: snapshot.data[index].p_description,
                    category: snapshot.data[index].p_category,
                    context: context,
                  );
                });
          }
          else {
            return CircularProgressIndicator();
          }
        }),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Cranes'),
            Container(
              //  margin: const EdgeInsets.only(right: 75),
              child: Image.asset(
                'images/logo-appbar.png',
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            tooltip: 'Show Notification',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Show Notification')));
            },
          ),
          VerticalDivider(
            color: Colors.black87,
          ),
          IconButton(
            icon:
            const Icon(Icons.settings_power, color: Color(0xFF545D68)),
            tooltip: 'Show Notification',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Show Notification')));
            },
          ),

        ],
      ),
      body: tabs[_currentIndex],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print('floatingActionButton clicked!!!');
      //     _callSAV(context);
      //   },
      //   child: Icon(Icons.call),
      //
      //   backgroundColor: Colors.red,
      // ),

      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        icon: Icons.add,
        activeIcon: Icons.remove,
        buttonSize: 56.0,
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.white,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            label: 'First',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.blue,
            label: 'Second',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Third',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end,
        hasNotch: true,
        hasInk: true,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Accueil")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.list_alt,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.list_alt,
                color: Colors.red,
              ),
              title: Text("Catalogue")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Colors.red,
              ),
              title: Text("Profil")),
        ],
      ),
    );
  }
}


/// Des fonctions a mettre dans un helper separe

Future<void> _callSAV(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Service Client'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Appelez-nous'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Passer l\'appel'),
            onPressed: () {
              FlutterPhoneDirectCaller.callNumber('121');
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

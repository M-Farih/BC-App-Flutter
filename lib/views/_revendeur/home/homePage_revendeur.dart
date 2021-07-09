import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/views/_revendeur/sugg_recl/reclamation.dart';
import 'package:bc_app/views/_revendeur/sugg_recl/reclamationMenu.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'dashboard_revendeur.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage_Revendeur extends StatefulWidget {

  @override
  _HomePage_RevendeurState createState() => _HomePage_RevendeurState();
}

class _HomePage_RevendeurState extends State<HomePage_Revendeur> {

  int _currentIndex = 0;
  final tabs = [
    Dashboard_revendeur(),
    ProductCategories(),
    ReclamationMenu()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// subscribe to firebase
    FirebaseMessaging.instance.subscribeToTopic('users');
    print('revendeur subscribed!');

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      int role_id = await Provider.of<AuthProvider>(context, listen: false).checkLoginAndRole();
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      switch(role_id){
        case 1:
          print('admin');
          break;
        case 2:
          print('commercial');
          break;
        case 3:
          print('revendeur');
          break;
        default:
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
      Provider.of<ContactProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var contactProvider = Provider.of<ContactProvider>(context, listen: false);
    return authProvider.userChekcerIsBusy
      ?Center(child: CircularProgressIndicator())
      :WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(
        ///appbar
        appBar: MyAppBar(isSeller: authProvider.currentUsr.idrole == 3 ?true :false, roleId: authProvider.currentUsr.idrole),

        ///body
        body: tabs[_currentIndex],

        ///bottom bar
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
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Color(0xff2C7DBF),
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Color(0xff2C7DBF),
                ),
                title: Text(
                  "الرئيسية",
                  textDirection: TextDirection.rtl
                )),
            BubbleBottomBarItem(
                backgroundColor: Color(0xff2C7DBF),
                icon: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.list,
                  color: Color(0xff2C7DBF),
                ),
                title: Text(
                    "المنتوجات",
                    textDirection: TextDirection.rtl
                )),
            BubbleBottomBarItem(
                backgroundColor: Color(0xff2C7DBF),
                icon: Icon(
                  Icons.support_agent,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.support_agent,
                  color: Color(0xff2C7DBF),
                ),
                title: Text(
                    "الدعم",
                    textDirection: TextDirection.rtl
                )),
          ],
        ),
    ),
      );
  }
}




import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/views/_commercial/sellers/listSellers.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'file:///C:/_myproject/flutter/BC-App-Flutter/lib/views/_revendeur/profil/profilPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'dashboard_commercial.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage_Commercial extends StatefulWidget {

  @override
  _HomePage_CommercialState createState() => _HomePage_CommercialState();
}

class _HomePage_CommercialState extends State<HomePage_Commercial> {

  int _currentIndex = 0;
  final tabs = [
    Dashboard_commercial(),
    ProductCategories(),
    ListSellers()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      int role_id = await Provider.of<AuthProvider>(context, listen: false).checkLoginAndRole();

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
      Provider.of<RistourneProvider>(context, listen: false).getRistourneImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var contactProvider = Provider.of<ContactProvider>(context, listen: false);
    return authProvider.userChekcerIsBusy
      ?Center(child: CircularProgressIndicator())
      :Scaffold(
      resizeToAvoidBottomInset: true,
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
                "Accueil",
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
                  "Catalogue ",
                  textDirection: TextDirection.rtl
              )),
          BubbleBottomBarItem(
              backgroundColor: Color(0xff2C7DBF),
              icon: Icon(
                Icons.people,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.people,
                color: Color(0xff2C7DBF),
              ),
              title: Text(
                  "Revendeurs",
                  textDirection: TextDirection.rtl
              )),
        ],
      ),
    );
  }
}




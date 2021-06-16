import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/views/_admin/home/dashboard_admin.dart';
import 'package:bc_app/views/_admin/sellers/listSellersAdmin.dart';
import 'package:bc_app/views/_commercial/sellers/listSellers.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage_admin extends StatefulWidget {
  @override
  _HomePage_adminState createState() => _HomePage_adminState();
}

class _HomePage_adminState extends State<HomePage_admin> {
  int _currentIndex = 0;
  final tabs = [
    Dashboard_admin(),
    ProductCategories(),
    ListSellersAdmin()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('admin home page');
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      Provider.of<ContactProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    return authProvider.userChekcerIsBusy
        ?Center(child: Text('home page admin...'))
        :Scaffold(
      resizeToAvoidBottomInset: true,
      ///appbar
      appBar: MyAppBar(isSeller: false, roleId: 1),

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

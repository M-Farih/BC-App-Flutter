import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/profil/profilPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'dashboard/revendeur/dashboard_revendeur.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final tabs = [
    Dashboard_revendeur(),
    ProductCategories(),
    ProfilePage()
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
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var contactProvider = Provider.of<ContactProvider>(context, listen: false);
    return authProvider.busy
      ?Center(child: CircularProgressIndicator())
      :Scaffold(
      resizeToAvoidBottomInset: true,
      ///appbar
      appBar: MyAppBar(),

      ///body
      body: tabs[_currentIndex],

      ///floating btn
      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        icon: Icons.add,
        activeIcon: Icons.add,
        buttonSize: 56.0,
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.blue,
        overlayOpacity: 0.5,
        onOpen: () {},
        onClose: () {},
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Color(0xff2C7DBF),
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.phone_in_talk_rounded, color: Colors.white),
            backgroundColor: Color(0xFF1DC1C3),
            label: 'إتصال',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black54),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
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
                        contactProvider.callBc();
                      },
                    ),
                    FlatButton(
                      child: Text('غلق', textDirection: TextDirection.rtl),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              );

            },
          ),
          SpeedDialChild(
            child: Icon(Icons.thumb_up, color: Colors.white),
            backgroundColor: Color(0xFFFC8F6E),
            label: 'اقتراحات',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black54),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('reclamation');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.feedback, color: Colors.white),
            backgroundColor: Color(0xFFF67B97),
            label: 'مطالبة',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black54,),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('reclamation');
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
        fabLocation: BubbleBottomBarFabLocation.end,
        hasNotch: true,
        hasInk: true,
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
                Icons.list_alt,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.list_alt,
                color: Color(0xff2C7DBF),
              ),
              title: Text(
                  "المنتوجات",
                  textDirection: TextDirection.rtl
              )),
          BubbleBottomBarItem(
              backgroundColor: Color(0xff2C7DBF),
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff2C7DBF),
              ),
              title: Text(
                  "الملف الشخصي",
                  textDirection: TextDirection.rtl
              )),
        ],
      ),
    );
  }
}




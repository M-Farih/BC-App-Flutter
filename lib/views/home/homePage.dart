import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/services/contactingService.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/productCategories.dart';
import 'package:bc_app/views/profil/profilPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dashboard/dashboard.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AuthentificationService authService = new AuthentificationService();
  ContactingService cs = new ContactingService();

  @protected
  @mustCallSuper
  void initState() {
    authService.checkLogin().then((success) {
      print('success status $success');

    });
  }



  int _currentIndex = 0;

  final tabs = [
    Dashboard(),
    // FutureBuilder(
    //     future: ProductService.fillProduct(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return ListView.builder(
    //             itemCount: snapshot.data.length,
    //             itemBuilder: (context, int index) {
    //               return ProductCard(
    //                 name: snapshot.data[index].p_title,
    //                 price: snapshot.data[index].p_price,
    //                 imgPath: snapshot.data[index].p_image,
    //                 desc: snapshot.data[index].p_description,
    //                 category: snapshot.data[index].p_category,
    //                 context: context,
    //               );
    //             });
    //       }
    //       else {
    //         return CircularProgressIndicator();
    //       }
    //     }),
    ProductCategories(),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
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
              print('Calling BC');
              cs.callSAV(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.thumb_up, color: Colors.white),
            backgroundColor: Color(0xFFFC8F6E),
            label: 'اقتراحات',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black54),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.feedback, color: Colors.white),
            backgroundColor: Color(0xFFF67B97),
            label: 'مطالبة',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.black54),
            onTap: () => print('THIRD CHILD'),
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




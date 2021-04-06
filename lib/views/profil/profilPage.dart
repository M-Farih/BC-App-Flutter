import 'package:bc_app/views/widgets/infoContainer.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.0),

            ///user card
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    //color: Colors.purple,
                    borderRadius: BorderRadius.circular(15.0),
                    image: new DecorationImage(
                      //image: new AssetImage('images/g.jpg'),
                      image: new AssetImage('images/user-card.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      Stack(
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage('images/profil.jpg'),
                            ),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(50.0)),
                              border: new Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                          Positioned(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.white)),
                                color: Color(0xFFF5F6F9),
                                onPressed: () =>
                                    print('click to change picture'),
                                child: Icon(Icons.camera_alt, size: 21.0),
                              ),
                            ),
                            bottom: 1,
                            right: 1,
                          )
                        ],
                      ),
                      SizedBox(height: 05.0),
                      Text(
                        'حميد العلمي',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                      Text(
                        'DHD45DD4',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            ///user info
            InfoContainer(text: 'حميد العلمي'),
            InfoContainer(text: 'إسم الشركة'),
            InfoContainer(text: 'ICE : 00 000000'),
            InfoContainer(text: 'المدينة'),
            InfoContainer(text: 'العنوان'),
            InfoContainer(text: '+212 6 00 00 00 00'),
            SizedBox(height: 10.0),

            ///btn
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: ProfilInfoBtn(text: 'تعديل', color: 0xFF2C7DBF, textColor: 0xFFFFFFFF),
                    onTap: () => print('تعديل'),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    child: ProfilInfoBtn(text: 'حفض', color: 0xFFFFFFFF, textColor: 0xFF2C7DBF),
                    onTap: () => print('حفض'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

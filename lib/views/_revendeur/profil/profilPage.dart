import 'dart:io';

import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/services/userService.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/infoContainer.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool canEdit;
  bool imageChosen = false;
  int id, role_id, agentIduser, btnColor, btntextColor;
  String btntext, fname, lname, company, ice, city, address, phone, email;

  String image =
      "https://toppng.com/uploads/preview/donna-picarro-dummy-avatar-115633298255iautrofxa.png";

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageChosen = true;
      }
    });
  }

  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  TextEditingController iceController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  double inputFullWith = 1;
  double inputHalfWith = 0.43;

  @override
  void initState() {
    super.initState();
    canEdit = false;

    if (!canEdit) {
      btntext = 'تعديل';
      btntextColor = 0xFF2C7DBF;
      btnColor = 0xFFFFFFFF;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      Provider.of<AuthProvider>(context, listen: false)
          .getUserFromSP()
          .then((value) {
        Provider.of<UserProvider>(context, listen: false)
            .getSellerByIdForSp(
                Provider.of<AuthProvider>(context, listen: false).iduser)
            .then((value) {
          id = authProvider.iduser;
          fname = userProvider.currentUser.firstName;
          lname = userProvider.currentUser.lastName;
          company = userProvider.currentUser.entrepriseName;
          ice = userProvider.currentUser.ice;
          city = userProvider.currentUser.city;
          address = userProvider.currentUser.address;
          phone = userProvider.currentUser.telephone;
          agentIduser = userProvider.currentUser.agentIduser;
          role_id = userProvider.currentUser.idrole;
          email = userProvider.currentUser.email;

          fnameController.text = fname;
          lnameController.text = lname;
          companyController.text = company;
          iceController.text = ice;
          cityController.text = city;
          addressController.text = address;
          phoneController.text = phone;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false,
          roleId: authProvider.currentUsr.idrole),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: authProvider.spbusy
              ? Center(child: CircularProgressIndicator())
              : userProvider.busy
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        ///back btn & icon-title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).pushReplacementNamed('home-revendeur');
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => authProvider
                                                          .currentUsr.idrole ==
                                                      3
                                                  ? HomePage_Revendeur(index: 0)
                                                  : authProvider.currentUsr
                                                              .idrole ==
                                                          2
                                                      ? HomePage_Commercial(
                                                          index: 2)
                                                      : HomePage_admin(
                                                          index: 2)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: 80,
                                        height: 40,
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.arrow_back, size: 17),
                                            Text(
                                              'رجوع',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w300),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

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
                                  image: new AssetImage(
                                      'assets/images/user-card.png'),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.0),
                                  Stack(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(height: 10.0),
                                          Container(
                                            child: CircleAvatar(
                                                radius: 40.0,
                                                backgroundImage: _image == null
                                                    ? NetworkImage(userProvider
                                                                .currentUserImage !=
                                                            ""
                                                        ? userProvider
                                                            .currentUserImage
                                                        : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=$lname+$fname")
                                                    : FileImage(_image)),
                                            decoration: new BoxDecoration(
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(50.0)),
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: FlatButton(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                side: BorderSide(
                                                    color: Colors.white)),
                                            color: Color(0xFFF5F6F9),
                                            onPressed: () {
                                              if (imageChosen) {
                                                userProvider
                                                    .updateImage(
                                                        id, _image.path)
                                                    .then((value) {
                                                  _confirmation(context,
                                                      'لقد تم تحديث الصورة الشخصية');
                                                });
                                              } else
                                                getImage();
                                            },
                                            child: Icon(
                                                imageChosen
                                                    ? Icons.upload_rounded
                                                    : Icons.camera_alt,
                                                size: 21.0),
                                          ),
                                        ),
                                        bottom: 1,
                                        right: 1,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 05.0),
                                  authProvider.currentUsr == null
                                      ? Text('')
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${authProvider.currentUsr.firstName + ' ' + authProvider.currentUsr.lastName}',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0),
                                                  ),
                                                ],
                                              ),
                                              authProvider.currentUsr == null
                                                  ? Text('')
                                                  : Text(
                                                      '${authProvider.currentUsr.idvendor}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '${authProvider.ristourne}',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),

                        ///user info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoContainer(
                                      label: 'الاسم',
                                      vec: inputHalfWith,
                                      textController: fnameController,
                                      canEdit: canEdit,
                                      td: TextDirection.ltr),
                                  SizedBox(width: 5),
                                  InfoContainer(
                                      label: 'النسب',
                                      vec: inputHalfWith,
                                      textController: lnameController,
                                      canEdit: canEdit,
                                      td: TextDirection.ltr),
                                ],
                              ),
                              InfoContainer(
                                  label: 'الشركة',
                                  vec: inputFullWith,
                                  textController: companyController,
                                  canEdit: canEdit,
                                  td: TextDirection.ltr),
                              InfoContainer(
                                  label: 'التعريف الموحد للمقاولة',
                                  vec: inputFullWith,
                                  textController: iceController,
                                  canEdit: false,
                                  td: TextDirection.ltr),
                              InfoContainer(
                                  label: 'المدينة',
                                  vec: inputFullWith,
                                  textController: cityController,
                                  canEdit: canEdit,
                                  td: TextDirection.ltr),
                              InfoContainer(
                                  label: 'العنوان',
                                  vec: inputFullWith,
                                  textController: addressController,
                                  canEdit: canEdit,
                                  td: TextDirection.ltr),
                              InfoContainer(
                                  label: 'رقم الهاتف',
                                  vec: inputFullWith,
                                  textController: phoneController,
                                  canEdit: canEdit,
                                  td: TextDirection.ltr),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),

                        ///btn
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: ProfilInfoBtn(
                                    btnHeight: 35,
                                    btnWidth: canEdit ? 180 : 80,
                                    text: '$btntext',
                                    color: btnColor,
                                    textColor: btntextColor),
                                onTap: () {
                                  setState(() {
                                    canEdit = !canEdit;
                                    if (canEdit) {
                                      btntext = 'إرسال طلب التعديل';
                                      btntextColor = 0xFFFFFFFF;
                                      btnColor = 0xFF2C7DBF;
                                    } else {
                                      btntext = 'تعديل';
                                      btntextColor = 0xFF2C7DBF;
                                      btnColor = 0xFFFFFFFF;
                                      setState(() {
                                        userProvider
                                            .update(
                                                id,
                                                authProvider
                                                    .currentUsr.idvendor,
                                                fnameController.text,
                                                lnameController.text,
                                                companyController.text,
                                                iceController.text,
                                                cityController.text,
                                                addressController.text,
                                                phoneController.text,
                                                role_id,
                                                email)
                                            .then((value) {
                                          _confirmation(context,
                                              'لقد تم ارسال طلب التعديل');
                                        });
                                      });
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

Future<void> _confirmation(context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Confirmation',
          textDirection: TextDirection.rtl,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('$text', textDirection: TextDirection.ltr),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      );
    },
  );
}

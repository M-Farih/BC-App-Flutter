import 'dart:io';

import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
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
  String btntext, fname, lname, company, ice, city, address, phone;

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
      } else {
        print('No image selected.');
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
    // TODO: implement initState
    super.initState();
    canEdit = false;

    if (!canEdit) {
      btntext = 'تعديل';
      btntextColor = 0xFF2C7DBF;
      btnColor = 0xFFFFFFFF;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.spbusy) {
      print('image --- ${authProvider.currentUsr.profileImage}');
      print('id --- ${authProvider.iduser}');
      print('id2 --- ${authProvider.currentUsr.iduser}');
      print('idrole --- ${authProvider.currentUsr.idrole}');
      id = authProvider.iduser;
      fname = authProvider.currentUsr.firstName;
      lname = authProvider.currentUsr.lastName;
      company = authProvider.currentUsr.entrepriseName;
      ice = authProvider.currentUsr.ice;
      city = authProvider.currentUsr.city;
      address = authProvider.currentUsr.address;
      phone = authProvider.currentUsr.telephone;
      image = authProvider.currentUsr.profileImage.isNotEmpty
          ? authProvider.currentUsr.profileImage.replaceAll('"', '')
          : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=$lname+$fname";
      agentIduser = authProvider.currentUsr.agentIduser;
      role_id = authProvider.currentUsr.idrole;

      fnameController.text = fname;
      lnameController.text = lname;
      companyController.text = company;
      iceController.text = ice;
      cityController.text = city;
      addressController.text = address;
      phoneController.text = phone;
    }
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                      authProvider.currentUsr.idrole == 3
                                          ?HomePage_Revendeur(index: 2)
                                          :authProvider.currentUsr.idrole == 2
                                          ?HomePage_Commercial(index: 2)
                                          :HomePage_admin(index: 2)
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                              image:
                                  new AssetImage('assets/images/user-card.png'),
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
                                            radius: 50.0,
                                            backgroundImage: _image == null
                                                ? NetworkImage(image)
                                                : FileImage(_image)),
                                        decoration: new BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(50.0)),
                                          border: new Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  canEdit
                                      ? Positioned(
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
                                                getImage();
                                              },
                                              child: Icon(Icons.camera_alt,
                                                  size: 21.0),
                                            ),
                                          ),
                                          bottom: 1,
                                          right: 1,
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              SizedBox(height: 05.0),
                              authProvider.currentUsr == null
                                  ? Text('')
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${authProvider.currentUsr.firstName + ' ' + authProvider.currentUsr.lastName}',
                                            textDirection: TextDirection.rtl,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                    ),
                              authProvider.currentUsr == null
                                  ? Text('')
                                  : Text(
                                      '${authProvider.currentUsr.clientNumber}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                btnWidth: 80,
                                text: '$btntext',
                                color: btnColor,
                                textColor: btntextColor),
                            onTap: () {
                              print('image /----> $image');
                              setState(() {
                                canEdit = !canEdit;
                                if (canEdit) {
                                  btntext = 'حفظ';
                                  btntextColor = 0xFFFFFFFF;
                                  btnColor = 0xFF2C7DBF;
                                } else {
                                  btntext = 'تعديل';
                                  btntextColor = 0xFF2C7DBF;
                                  btnColor = 0xFFFFFFFF;
                                  setState(() {
                                    if (imageChosen) {
                                      print('id to update --> ${id}');
                                      userProvider.update(
                                          id,
                                          authProvider.currentUsr.clientNumber,
                                          fnameController.text,
                                          lnameController.text,
                                          companyController.text,
                                          iceController.text,
                                          cityController.text,
                                          addressController.text,
                                          phoneController.text,
                                          role_id,
                                          _image.path);
                                    }
                                    else {
                                      print('a = ${agentIduser}');
                                      userProvider.update(
                                          id,
                                          authProvider.currentUsr.clientNumber,
                                          fnameController.text,
                                          lnameController.text,
                                          companyController.text,
                                          iceController.text,
                                          cityController.text,
                                          addressController.text,
                                          phoneController.text,
                                          role_id,
                                          "");
                                    }
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

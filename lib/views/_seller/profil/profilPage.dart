import 'dart:convert';
import 'dart:io';

import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/services/userService.dart';
import 'package:bc_app/views/widgets/infoContainer.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool canEdit;
  bool imageChosen = false;
  int id, role_id;
  String btntext, fname, lname, company, ice, city, address, phone, agentNumber;

  String image="https://toppng.com/uploads/preview/donna-picarro-dummy-avatar-115633298255iautrofxa.png";

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    canEdit = false;
    btntext = 'تعديل';

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var _user = Provider.of<AuthProvider>(context, listen: false).currentUser;
      if(_user == null){
        Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: true);

      if(!authProvider.spbusy) {
        print('image --- ${authProvider.currentUser.profileImage}');
        id = authProvider.currentUser.iduser;
        fname = authProvider.currentUser.firstName;
        lname = authProvider.currentUser.lastName;
        company = authProvider.currentUser.entrepriseName;
        ice = authProvider.currentUser.ice;
        city = authProvider.currentUser.city;
        address = authProvider.currentUser.address;
        phone =authProvider.currentUser.telephone;
        image = authProvider.currentUser.profileImage != "" ? authProvider.currentUser.profileImage.replaceAll('"', '') : "https://ui-avatars.com/api/?background=FFFFF&color=2C7DBF&name=$lname+$fname";
        agentNumber = authProvider.currentUser.agentNumber;
        role_id = authProvider.currentUser.idrole;


        fnameController.text = fname;
        lnameController.text = lname;
        companyController.text = company;
        iceController.text = ice;
        cityController.text = city;
        addressController.text = address;
        phoneController.text = phone;
      }
        return Scaffold(
          body: SingleChildScrollView(
            child: authProvider.spbusy
                ? Center(child: CircularProgressIndicator())
                : Column(
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
                          image: new AssetImage('images/user-card.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10.0),
                          Stack(
                            children: [
                              Container(
                                child: CircleAvatar(
                                    radius: 50.0,
                                    //backgroundImage: AssetImage('images/profil.jpg'),
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
                                  : Text('')
                            ],
                          ),
                          SizedBox(height: 05.0),
                          authProvider.currentUser == null
                              ? Text('')
                              : Text(
                            '${authProvider.currentUser.firstName +' '+authProvider.currentUser.lastName}',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                          ),
                          authProvider.currentUser == null
                              ?Text('')
                              :Text(
                            '${authProvider.currentUser.ice}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),

                ///user info
                Column(
                  children: [
                    InfoContainer(
                        textController: fnameController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                    InfoContainer(
                        textController: lnameController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                    InfoContainer(
                        textController: companyController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                    InfoContainer(
                        textController: iceController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                    InfoContainer(
                        textController: cityController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                    InfoContainer(
                        textController: addressController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                    InfoContainer(
                        textController: phoneController,
                        canEdit: canEdit,
                        td: TextDirection.ltr),
                  ],
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
                            text: '$btntext',
                            color: 0xFF2C7DBF,
                            textColor: 0xFFFFFFFF),
                        onTap: () {
                          setState(() {
                            canEdit = !canEdit;
                            if (canEdit) {
                              btntext = 'حفض';
                            } else {
                              btntext = 'تعديل';
                              setState(() {
                                if (imageChosen) {
                                  userProvider.update(id.toString(), fnameController.text, lnameController.text, companyController.text, iceController.text, cityController.text, addressController.text, phoneController.text, role_id.toString(), _image.path);
                                  authProvider.updateCurrentUser(fnameController.text, lnameController.text, companyController.text, iceController.text, cityController.text, addressController.text, phoneController.text, image);
                                }else{
                                  print('a = ${agentNumber}');
                                  userProvider.update(id.toString(), fnameController.text, lnameController.text, companyController.text, iceController.text, cityController.text, addressController.text, phoneController.text, role_id.toString(), "");
                                  authProvider.updateCurrentUser(fnameController.text, lnameController.text, companyController.text, iceController.text, cityController.text, addressController.text, phoneController.text, image);
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
        );
      }
  }



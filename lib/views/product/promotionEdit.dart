import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/promotionProvider.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/promotionAdd.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class PromotionEdit extends StatefulWidget {
  final String idpromo, promo;

  const PromotionEdit({Key key, this.idpromo, this.promo}) : super(key: key);

  @override
  _PromotionEditState createState() => _PromotionEditState();
}

class _PromotionEditState extends State<PromotionEdit> {
  bool imageChosen = false;
  int _value = 1;
  final _key = GlobalKey<FormState>();

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

  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PromotionProvider>(context, listen: false).getPromotions();

      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var promoProvider = Provider.of<PromotionProvider>(context);
    var progressDialog = ProgressDialog(context);
    return Scaffold(
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text(
              'Modifier la promotion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            /// add
            Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          height: 360,
                          width: 280,
                          child: Column(
                            children: [
                              Container(
                                width: 280,
                                height: 280,
                                child: _image == null
                                    ? Center(
                                        child: Image.network(
                                          widget.promo.replaceAll('"', '').trim(),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                child: Icon(Icons.photo_camera,
                                    size: 36,
                                    color: Colors.black54),
                                onTap: () => getImage(),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                /// modifier btn
                Center(
                    child: Column(
                  children: [
                    GestureDetector(
                      child: ProfilInfoBtn(text: "Modifier", color: 0xFF2C7DBF, textColor: 0xFFFFFFFF, btnHeight: 50, btnWidth: 120,),
                      onTap: () async {
                        if (_image != null) {
                          progressDialog.show();
                          promoProvider
                              .updatePromo(_image.path, widget.idpromo)
                              .whenComplete(() {
                            progressDialog.hide();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PromotionAdd()));
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              message: "Promotion modifiée",
                              duration: Duration(seconds: 3),
                            )..show(context);
                          });
                        } else {
                          Flushbar(
                            flushbarPosition: FlushbarPosition.TOP,
                            message: "Aucune photo selectionée",
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          )..show(context);
                        }
                      },
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

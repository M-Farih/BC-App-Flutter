import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/productProvider.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  final bool isAdd;
  final String name, description, image, id;

  const ProductAdd(
      {Key key, this.isAdd, this.name, this.description, this.image, this.id})
      : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  bool imageChosen = false;
  int _value = 1;
  final _key = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final descriptionController = TextEditingController();

  String image =
      "https://toppng.com/uploads/preview/donna-picarro-dummy-avatar-115633298255iautrofxa.png";
  File _image;
  final picker = ImagePicker();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future getImage() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request().isGranted.whenComplete(() async {
        final pickedFile = await picker.getImage(source: ImageSource.gallery);

        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
            imageChosen = true;
          }
        });
      });
    } else {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          imageChosen = true;
        }
      });
    }
  }

  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();
      if (!widget.isAdd) {
        Provider.of<ProductProvider>(context, listen: false)
            .getProductById('20');
      }
    });

    if (!widget.isAdd) {
      nomController.text = widget.name;
      descriptionController.text = widget.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var productProvider = Provider.of<ProductProvider>(context, listen: true);
    var progressDialog = ProgressDialog(context);
    return Scaffold(
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false,
          roleId: authProvider.currentUsr.idrole),
      body: productProvider.isBusy
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    /// back btn & icon-title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('home-admin');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.arrow_back),
                                        Text(
                                          'Retour',
                                          style: TextStyle(fontSize: 20.0),
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
                    SizedBox(height: 20),
                    widget.isAdd
                        ? Text(
                            'Ajouter un nouveau produit',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Modifier un produit',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            child: Container(
                              height: 180,
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                      width: 140,
                                      height: 140,
                                      child: _image == null
                                          ? Center(
                                              child: !widget.isAdd
                                                  ? Image.network(widget.image)
                                                  : Text('Ajouter une image'))
                                          : Image.file(
                                              _image,
                                              fit: BoxFit.cover,
                                            )),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    child: Icon(Icons.photo_camera,
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

                    ///dropdown
                    Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: widget.isAdd
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.88,
                                padding: EdgeInsets.all(18.0),
                                child: DropdownButtonFormField(
                                    hint: Text('Choisissez une famille'),
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'Choisissez une famille'),
                                    value: _value,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Salon"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Divers"),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("Banquette"), value: 3),
                                      DropdownMenuItem(
                                          child: Text("Matelas"), value: 4)
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    }),
                              )
                            : SizedBox()),

                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                            child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildTextField(
                                      "Nom de produit", nomController),
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                            child: Container(
                              height: 180,
                              child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buildTextField(
                                        "Description de produit",
                                        descriptionController),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// ajouter btn
                    Center(
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width * 0.28,
                        height: 44,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              progressDialog.show();
                              if (widget.isAdd) {
                                productProvider
                                    .addProduct(
                                        nomController.text,
                                        descriptionController.text,
                                        _image.path,
                                        _value.toString())
                                    .whenComplete(() {
                                      image = "";
                                  progressDialog.hide();
                                  nomController.text = "";
                                  descriptionController.text = "";
                                }).whenComplete(() {
                                  _confirmation(context);
                                });
                              }
                              else {
                                if (imageChosen) {
                                  productProvider
                                      .updateProduct(
                                          nomController.text,
                                          descriptionController.text,
                                          _image.path,
                                          _value.toString(),
                                          widget.id)
                                      .whenComplete(() {
                                    progressDialog.hide();
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: "Produit Modifié",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  });
                                } else {
                                  productProvider
                                      .updateProduct(
                                          nomController.text,
                                          descriptionController.text,
                                          "",
                                          _value.toString(),
                                          widget.id)
                                      .whenComplete(() {
                                    progressDialog.hide();
                                    Flushbar(
                                      flushbarPosition: FlushbarPosition.TOP,
                                      message: "Produit Modifié",
                                      duration: Duration(seconds: 3),
                                    )..show(context);
                                  });
                                }
                              }
                            }
                          },
                          color: Color(0xFF2C7DBF),
                          textColor: Colors.white,
                          child: Text(
                            widget.isAdd ? "Ajouter" : "Modifier",
                            style: TextStyle(fontSize: 19.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildTextField(String hintText, controller) {
    return TextFormField(
      validator: (v) {
        if (v.isEmpty) {
          return 'Champs obligatoire';
        } else {
          return null;
        }
      },
      controller:
          controller == nomController ? nomController : descriptionController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: InputBorder.none,
      ),
      maxLines: controller == descriptionController ? 15 : 1,
      keyboardType: TextInputType.text,
    );
  }
}

Future<void> _confirmation(context) async {
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
              Text('Opération terminée avec succès',
                  textDirection: TextDirection.ltr),
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
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (context) => ProductAdd(isAdd: true)));
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

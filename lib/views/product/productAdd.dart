import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/productProvider.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {

  final bool isAdd;
  final String name, description, image, id;
  const ProductAdd({Key key, this.isAdd, this.name, this.description, this.image, this.id}) : super(key: key);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();
      if(!widget.isAdd){
        Provider.of<ProductProvider>(context, listen: false).getProductById('20');
      }

      switch(role_id){
        case 0:
          print('super admin');
          break;
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
    });

    if(!widget.isAdd){
      nomController.text = widget.name;
      descriptionController.text = widget.description;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var productProvider = Provider.of<ProductProvider>(context, listen: true);
    var progressDialog = ProgressDialog(context);
    // !productProvider.isBusy ?nomController.text = productProvider.product[0].image.replaceAll('"', '').trim() :print('_');
    return Scaffold(
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false,
          roleId: authProvider.currentUsr.idrole),
      body: productProvider.isBusy
          ?Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              widget.isAdd
                  ?Text('Ajouter un nouveau produit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  :Text('Modifier un produit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                                      ?Image.network(widget.image)
                                      :Text('Ajouter une image')
                                )
                                    : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(height: 8),
                            GestureDetector(
                              child: Icon(Icons.photo_camera, color: Colors.black54),
                              onTap: ()=> getImage(),
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
                      ?Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    padding: EdgeInsets.all(18.0),
                    child: DropdownButtonFormField(
                        hint: Text('Choisissez une famille'),
                        decoration: InputDecoration.collapsed(hintText: 'Choisissez une famille'),
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text("Salon"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Matelas"),
                            value: 2,
                          ),
                          DropdownMenuItem(child: Text("Banquette"), value: 3),
                          DropdownMenuItem(child: Text("Divers"), value: 4)
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        }),
                  )
                      :SizedBox()
              ),

              Form(
                key: _key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                            buildTextField("Nom de produit", nomController),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                      child: Container(
                        height: 180,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildTextField("Description de produit",
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
                        if(widget.isAdd){
                          productProvider.addProduct(nomController.text, descriptionController.text, _image.path, _value.toString()).whenComplete(() {
                            progressDialog.hide();
                            nomController.text = "";
                            descriptionController.text = "";
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              message: "Produit Ajouté",
                              duration: Duration(seconds: 3),
                            )..show(context);
                          });
                        }
                        else{
                          print('id --? ${widget.id}');
                          productProvider.updateProduct(nomController.text, descriptionController.text, _image.path, _value.toString(), widget.id).whenComplete(() {
                            progressDialog.hide();
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              message: "Produit Modifié",
                              duration: Duration(seconds: 3),
                            )..show(context);
                          });
                        }
                      }
                      else
                        print('is not validate');
                    },
                    color: Color(0xFF2C7DBF),
                    textColor: Colors.white,
                    child: Text(
                      widget.isAdd ?"Ajouter" :"Modifier",
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
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/promotionProvider.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/product/promotionEdit.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class PromotionAdd extends StatefulWidget {
  @override
  _PromotionAddState createState() => _PromotionAddState();
}

class _PromotionAddState extends State<PromotionAdd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PromotionProvider>(context, listen: false).getPromotions();

      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();

      switch (role_id) {
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
  }

  bool imageChosen = false;
  bool pdfChosen = false;
  int _value = 1;
  final _key = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final descriptionController = TextEditingController();

  String image =
      "https://toppng.com/uploads/preview/donna-picarro-dummy-avatar-115633298255iautrofxa.png";
  File _image;
  File _pdf;
  final picker = ImagePicker();
  int pdfIconColor = 0xFF707070;

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

  Future getPdf() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _pdf = File(result.files.single.path);
      pdfChosen = true;
      setState(() {
        pdfIconColor = 0xFF2C7DBF;
      });
    } else {
      print('no pdf selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    var promoProvider = Provider.of<PromotionProvider>(context);
    var progressDialog = ProgressDialog(context);
    return Scaffold(
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false),
      body: promoProvider.isBusy
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Ajouter une nouvelle promotion',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                              Column(
                                children: [
                                  Card(
                                    child: Container(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 140,
                                            height: 140,
                                            child: _image == null
                                                ? Center(
                                                    child:
                                                    !imageChosen
                                                        ? GestureDetector(
                                                      child: Icon(
                                                          Icons.photo_camera,
                                                          color: Colors.black54,
                                                          size: 50,
                                                      ),
                                                      onTap: () => getImage(),
                                                    )
                                                        : GestureDetector(
                                                      child: Icon(Icons.file_upload,
                                                          size: 30,
                                                          color: Color(0xFF2C7DBF)),
                                                      onTap: () async {
                                                        if (_image != null) {
                                                          progressDialog.show();
                                                          promoProvider
                                                              .addPromo(
                                                              _image.path, "2")
                                                              .whenComplete(() {
                                                            progressDialog.hide();
                                                            Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                        PromotionAdd()));
                                                            Flushbar(
                                                              flushbarPosition:
                                                              FlushbarPosition
                                                                  .TOP,
                                                              message:
                                                              "Promotion ajoutée",
                                                              duration: Duration(
                                                                  seconds: 3),
                                                            )..show(context);
                                                          });
                                                        } else {
                                                          Flushbar(
                                                            flushbarPosition:
                                                            FlushbarPosition
                                                                .TOP,
                                                            message:
                                                            "Aucune photo selectionée",
                                                            backgroundColor:
                                                            Colors.red,
                                                            duration: Duration(
                                                                seconds: 3),
                                                          )..show(context);
                                                        }
                                                      },
                                                    )
                                                  )
                                                : Stack(
                                                  fit: StackFit.expand,
                                                  children:[
                                                    Image.file(
                                                      _image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: RaisedButton(
                                                          color: Colors.white.withOpacity(0.6),
                                                            onPressed: (){
                                                              if (_image != null) {
                                                                progressDialog.show();
                                                                promoProvider
                                                                    .addPromo(
                                                                    _image.path, "2")
                                                                    .whenComplete(() {
                                                                  progressDialog.hide();
                                                                  Navigator.of(context).push(
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) =>
                                                                              PromotionAdd()));
                                                                  Flushbar(
                                                                    flushbarPosition:
                                                                    FlushbarPosition
                                                                        .TOP,
                                                                    message:
                                                                    "Promotion ajoutée",
                                                                    duration: Duration(
                                                                        seconds: 3),
                                                                  )..show(context);
                                                                });
                                                              } else {
                                                                Flushbar(
                                                                  flushbarPosition:
                                                                  FlushbarPosition
                                                                      .TOP,
                                                                  message:
                                                                  "Aucune photo selectionée",
                                                                  backgroundColor:
                                                                  Colors.red,
                                                                  duration: Duration(
                                                                      seconds: 3),
                                                                )..show(context);
                                                              }
                                                            },
                                                            child: Icon(
                                                                Icons.upload_rounded,
                                                              color: Colors.white,
                                                              size: 40,
                                                            )
                                                        )
                                                    ),
                                                  ]
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Promotion',
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Card(
                                    child: Container(
                                      height: 180,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          !pdfChosen
                                              ? GestureDetector(
                                                  child: Icon(
                                                    Icons.picture_as_pdf,
                                                    color: Color(pdfIconColor),
                                                    size: 50,
                                                  ),
                                                  onTap: () => getPdf(),
                                                )
                                              : GestureDetector(
                                                  child: Icon(
                                                    Icons.file_upload,
                                                    color: Color(pdfIconColor),
                                                    size: 50,
                                                  ),
                                                  onTap: () async {
                                                    if (_pdf != null) {
                                                      progressDialog.show();
                                                      promoProvider
                                                          .addPdf(_pdf.path)
                                                          .whenComplete(() {
                                                        progressDialog.hide();
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PromotionAdd()));
                                                        Flushbar(
                                                          flushbarPosition:
                                                              FlushbarPosition
                                                                  .TOP,
                                                          message:
                                                              "Catalogue ajouté",
                                                          duration: Duration(
                                                              seconds: 3),
                                                        )..show(context);
                                                      });
                                                    } else {
                                                      Flushbar(
                                                        flushbarPosition:
                                                            FlushbarPosition
                                                                .TOP,
                                                        message:
                                                            "Aucun catalogue selectioné",
                                                        backgroundColor:
                                                            Colors.red,
                                                        duration: Duration(
                                                            seconds: 3),
                                                      )..show(context);
                                                    }
                                                  },
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text('Catalogue',
                                      style: TextStyle(color: Colors.black54))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// modifier
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Divider(height: 60),
                    ),
                    Text(
                      'Supprimer une promotion',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 20),
                        GridView.count(
                            childAspectRatio: 1,
                            primary: false,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: List.generate(
                                promoProvider.promotions.length, (index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 130,
                                    width: 130,
                                    child: Card(
                                      child: Image.network(
                                        promoProvider.promotions[index].promo
                                            .replaceAll('"', '')
                                            .trim(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Icon(Icons.delete,
                                            color: Colors.red),
                                        onTap: () {
                                          print('delete');
                                          promoProvider.deletePromo(
                                              promoProvider
                                                  .promotions[index].idpromo
                                                  .toString());
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              );
                            })),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

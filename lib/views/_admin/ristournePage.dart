import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:bc_app/views/widgets/ristourneWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class RistournePage extends StatefulWidget {
  @override
  _RistournePageState createState() => _RistournePageState();
}

class _RistournePageState extends State<RistournePage> {

  final minController = TextEditingController();
  final maxController = TextEditingController();
  final percentageController = TextEditingController();

  ///image
  bool imageChosen = false;
  bool isLocal = false;
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    minController.dispose();
    maxController.dispose();
    percentageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('list users page');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<RistourneProvider>(context, listen: false).getRistournes();
      Provider.of<RistourneProvider>(context, listen: false).getRistourneImage();
    });
  }

  TextEditingController messageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var ristourneProvider = Provider.of<RistourneProvider>(context, listen: true);
    var progressDialog = ProgressDialog(context);
    return Scaffold(
        appBar: MyAppBar(
          isSeller: false, roleId: 1,
        ),
        body: ristourneProvider.isBusy
          ?Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
            child: Center(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Modifier la ristourne', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 20,),

                      ///ristourne image
                      !imageChosen
                          ?RistourneWidget(imageLink: ristourneProvider.image.toString(), isLocal: false,)
                          :RistourneWidget(imagePath: _image, isLocal: true,),
                      GestureDetector(
                        child: ProfilInfoBtn(color: 0xFF1B7DBB, textColor: 0xFFFFFFFF, text: !imageChosen ?'Modifier' :'Enregistrer', btnHeight: 40, btnWidth: !imageChosen ?100 :120),
                        onTap: (){
                          if(!imageChosen){
                            getImage();
                          }
                          else{
                            print('uploading image');
                            setState(() {
                              isLocal = true;
                              _image = _image;
                            });
                            ristourneProvider.uploadRistournePicture(_image.path);
                          }
                          imageChosen = !imageChosen;
                        },
                      ),
                      SizedBox(height: 40,),


                      ///header
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                height: 40,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Min', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                height: 40,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Max', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                height: 40,
                                width: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Pourcentage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Divider(),
                      ///body
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: ristourneProvider.ristournes.length,
                        itemBuilder: (context, index){
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                    height: 40,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${ristourneProvider.ristournes[index].min}', style: TextStyle(fontSize: 14),),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                    height: 40,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${ristourneProvider.ristournes[index].max != null ?ristourneProvider.ristournes[index].max :ristourneProvider.ristournes[index].min + ' ou plus'}",
                                          style: TextStyle(fontSize: 14),),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                    height: 40,
                                    width: 90,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${ristourneProvider.ristournes[index].percent}', style: TextStyle(fontSize: 14),),
                                      ],
                                    )),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: GestureDetector(
                                    child: Icon(Icons.edit),
                                    onTap: (){
                                      AwesomeDialog(
                                          context: context,
                                          customHeader: Icon(
                                            Icons.account_balance,
                                            size: 55,
                                          ),
                                          borderSide: BorderSide(
                                              color: Color(0xFF1B7DBB), width: 2),
                                          width: MediaQuery.of(context).size.width,
                                          buttonsBorderRadius:
                                          BorderRadius.all(Radius.circular(2)),
                                          headerAnimationLoop: false,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'INFO',
                                          desc: 'Dialog description here...',
                                          btnOkColor: Color(0xFF1B7DBB),
                                          body: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Directionality(
                                                  textDirection: TextDirection.ltr,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: 'Min',
                                                      border: null,
                                                      hintStyle: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    controller: minController,
                                                    keyboardType: TextInputType.multiline,
                                                    minLines: 1,
                                                    //Normal textInputField will be displayed
                                                    maxLines:
                                                    8, // when user presses enter it will adapt to it
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Directionality(
                                                  textDirection: TextDirection.ltr,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: 'Max',
                                                      border: null,
                                                      hintStyle: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    controller: maxController,
                                                    keyboardType: TextInputType.multiline,
                                                    minLines: 1,
                                                    //Normal textInputField will be displayed
                                                    maxLines:
                                                    8, // when user presses enter it will adapt to it
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Directionality(
                                                  textDirection: TextDirection.ltr,
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      hintText: 'Pourcentage',
                                                      border: null,
                                                      hintStyle: TextStyle(
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                    controller: percentageController,
                                                    keyboardType: TextInputType.multiline,
                                                    minLines: 1,
                                                    //Normal textInputField will be displayed
                                                    maxLines:
                                                    8, // when user presses enter it will adapt to it
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          showCloseIcon: true,
                                          btnOkText: 'Modifier',
                                          btnOkOnPress: (){
                                            progressDialog.show();
                                            print('ok');
                                            ristourneProvider.updateRistourne(ristourneProvider.ristournes[index].idristourne.toString(), minController.text, maxController.text, percentageController.text).then((v){
                                              progressDialog.hide();
                                            });
                                          },
                                        btnCancelText: 'Supprimer',
                                        btnCancelOnPress: (){
                                          progressDialog.show();
                                          ristourneProvider.deleteRistourne(ristourneProvider.ristournes[index].idristourne.toString()).then((value){
                                            progressDialog.hide();
                                          });
                                        }
                                      )..show().whenComplete(() {
                                        Navigator.of(context).pushReplacementNamed("ristourne-page");
                                      });
                                    },
                                  )
                              ),

                            ],
                          );
                        },
                      ),

                      ///add ristourne
                      Center(
                        child: GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF2C7DBF),
                              borderRadius: BorderRadius.circular(40)
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              customHeader: Icon(
                                Icons.account_balance,
                                size: 55,
                              ),
                              borderSide: BorderSide(
                                  color: Color(0xFF1B7DBB), width: 2),
                              width: MediaQuery.of(context).size.width,
                              buttonsBorderRadius:
                              BorderRadius.all(Radius.circular(2)),
                              headerAnimationLoop: false,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'INFO',
                              desc: 'Dialog description here...',
                              btnOkColor: Color(0xFF1B7DBB),
                              body: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Min',
                                          border: null,
                                          hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        controller: minController,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        //Normal textInputField will be displayed
                                        maxLines:
                                        8, // when user presses enter it will adapt to it
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Max',
                                          border: null,
                                          hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        controller: maxController,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        //Normal textInputField will be displayed
                                        maxLines:
                                        8, // when user presses enter it will adapt to it
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Pourcentage',
                                          border: null,
                                          hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        controller: percentageController,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        //Normal textInputField will be displayed
                                        maxLines:
                                        8, // when user presses enter it will adapt to it
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              showCloseIcon: true,
                              btnOkText: 'Ajouter',
                              btnOkOnPress: (){
                                progressDialog.show();
                                print('ok');
                                ristourneProvider.addRistourne(minController.text, maxController.text, percentageController.text).whenComplete((){
                                  progressDialog.hide();
                                  Navigator.of(context).pushNamed('ristourne-page');
                                });
                              }
                            )..show();
                          },
                        ),
                      )
                    ],
                  )
                ),
              ])
        ),
          )
    );
  }
}
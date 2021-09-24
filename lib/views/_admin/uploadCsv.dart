import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class UploadCsv extends StatefulWidget {
  const UploadCsv({key}) : super(key: key);

  @override
  _UploadCsvState createState() => _UploadCsvState();
}

class _UploadCsvState extends State<UploadCsv> {

  bool pdfChosen = false;
  File _pdf;
  final picker = ImagePicker();
  int pdfIconColor = 0xFF707070;

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
    var progressDialog = ProgressDialog(context);
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: MyAppBar(isSeller: false, roleId: 1),
      body: SingleChildScrollView(
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
                          Navigator.of(context).pop();
                          },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: 100,
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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

            Text('Modifier les chiffres d\'affaire des revendeurs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            Card(
              child: Container(
                width: 140,
                height: 160,
                child: !pdfChosen
                    ? GestureDetector(
                  child: Icon(
                    Icons.drive_folder_upload,
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
                      userProvider.uploadCsv(_pdf.path).whenComplete(() {
                        progressDialog.hide();
                        _confirmation(context);
                      });
                    } else {
                      Flushbar(
                        flushbarPosition:
                        FlushbarPosition
                            .TOP,
                        message:
                        "Aucun fichier selectionné",
                        backgroundColor:
                        Colors.red,
                        duration: Duration(
                            seconds: 3),
                      )..show(context);
                    }
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Future<void> _confirmation(context) async {
  print('disc clicked');
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
              Text('Opération terminée avec succès', textDirection: TextDirection.ltr),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok', style: TextStyle(color: Colors.red),),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('upload-csv');
            },
          ),
        ],
      );
    },
  );
}
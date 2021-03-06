import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/loaderDialog.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class BeASeller extends StatefulWidget {
  @override
  _BeASellerState createState() => _BeASellerState();
}

class _BeASellerState extends State<BeASeller> {

  final _key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  static bool isEmail(String em){
    String p = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    var contactProvider = Provider.of<ContactProvider>(context, listen: true);
    var progressDialog = ProgressDialog(context);

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.arrow_back, size: 17),
                      Text('رجوع',
                        style: TextStyle(
                            fontSize: 17
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Form(
                key: _key,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                        child: Text(
                            'خدمتك أولويتنا',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF131313)
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: buildTextField('الإسم الكامل')),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: buildTextField('رقم الهاتف')),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 80,
                                  child: buildTextField('البريد الإلكتروني')),
                            )),
                      ),
                ],
              )),
              Center(
                child: ButtonTheme(
                  minWidth: 150.0,
                  height: 45.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      if(_key.currentState.validate()){
                        _key.currentState.save();
                        progressDialog.show();
                        contactProvider.MailBc(nameController.text, phoneController.text, emailController.text).whenComplete(() => {
                          setState(() {
                            nameController.text = "";
                            phoneController.text = "";
                            emailController.text = "";
                            progressDialog.hide();
                            Flushbar(
                              message: 'لقد تم ارسال طلبكم',
                              duration: Duration(seconds: 3),
                            )..show(context);
                          })
                        });
                      }
                    },
                    color: Color(0xFF2C7DBF),
                    textColor: Colors.white,
                    child: Text(
                      'ارسال الطلب',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 19.0),
                    )
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    var myController = TextEditingController();
    var myIcon;
    var _keyboardType;
    switch (hintText) {
      case 'الإسم الكامل':
        {
          myController = nameController;
          myIcon = Icons.person;
          _keyboardType = TextInputType.text;
        }
        break;

      case 'رقم الهاتف':
        {
          myController = phoneController;
          myIcon = Icons.phone_android;
          _keyboardType = TextInputType.number;
        }
        break;

      case 'البريد الإلكتروني':
        {
          myController = emailController;
          myIcon = Icons.mail;
          _keyboardType = TextInputType.emailAddress;
        }
        break;
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        validator: (v) {
          if (v.isEmpty) {
            return 'ادخل الحقل';
          }
          else if(myController == emailController){
            if(!isEmail(v)){
              return 'البريد الالكتروني غير صحيح';
            }
            else {
              return null;
            }
          }
          else if(myController == phoneController){
            if(v.length != 10){
              return 'رقم الهاتف غير صحيح';
            }
            else
              return null;
          }

          else {
            return null;
          }
        },
        controller: myController,
        keyboardType: _keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(myIcon)
        ),
      ),
    );
  }

}

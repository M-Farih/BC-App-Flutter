import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/services/contactingService.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/loaderDialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

             contactProvider.isBusy
              ?Column(
               children: [
                 SizedBox(height: 10),
                 CircularProgressIndicator(),
                 SizedBox(height: 10),
               ],
             )
              :SizedBox(),
              Center(
                child: ButtonTheme(
                  minWidth: 150.0,
                  height: 50.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      if(_key.currentState.validate()){
                        _key.currentState.save();
                        contactProvider.MailBc(nameController.text, phoneController.text, emailController.text).whenComplete(() => {
                          setState(() {
                            nameController.text = "";
                            phoneController.text = "";
                            emailController.text = "";
                            Flushbar(
                              message: 'لقد تم ارسال طلبكم',
                              duration: Duration(seconds: 3),
                            )..show(context);
                          })
                        });
                      }
                      else
                        print('is not validate');
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 20.0,
                      ),
                      Text(
                        'رجوع',
                        style: TextStyle(fontSize: 20.0),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
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
    return TextFormField(
      validator: (v) {
        if (v.isEmpty) {
          return 'input requird';
        }
        else if(myController == emailController){
          if(!isEmail(v)){
            return 'Invalid Email format';
          }
          else {
            return null;
          }
        }
        else if(myController == phoneController){
          if(v.length != 10){
            return 'short phone number';
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
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: InputBorder.none,
        prefixIcon: Icon(myIcon),
      ),
    );
  }

}

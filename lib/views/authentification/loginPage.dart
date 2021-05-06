import 'dart:convert';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/views/home/homePage.dart';
import 'package:bc_app/views/revendeur/beASeller.dart';
import 'package:bc_app/views/widgets/loaderDialog.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  static String routeName = 'login';

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final _key = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthentificationService authService = new AuthentificationService();

  bool _isHidden = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Provider.of<AuthProvider>(context, listen: false).login();
    });
  }


  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// logo
                  Row(

                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                            width: MediaQuery.of(context).size.width,
                            child: Image(image: AssetImage('images/logo3d.png'))
                        )
                      ],
                    ),
                  /// login input form
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
                                child: buildTextField("البريد الإلكتروني", emailController),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                          child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: buildTextField("كلمة السر", passwordController),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// login btn
                  Center(
                    child: ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 50.0,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          //_login();
                          if(_key.currentState.validate()){
                            _key.currentState.save();
                            bool login = await authProvider.login(emailController.text, passwordController.text);
                            if(login){
                              Navigator.of(context).pushReplacementNamed('home');
                            }else
                              print('can\'t login');
                          }else
                            print('is not validate');
                        },
                        color: Color(0xFF2C7DBF),
                        textColor: Colors.white,
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 19.0
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'هل نسيت كلمة السر',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Colors.black87
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Column(
                    children: [
                      Center(
                        child: ButtonTheme(
                          height: 50.0,
                          child: RaisedButton(
                            shape: CircleBorder(),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed('be_a_seller');
                            },
                            color: Color(0xFF2C7DBF),
                            textColor: Colors.white,
                            child: Icon(
                              Icons.add
                            )
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'كن موزعًا',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                color: Color(0xFFF67B97),
                              fontSize: 19.0
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget buildTextField(String hintText, controller){
    return TextFormField(
      validator: (v) {
        if (v.isEmpty) {
          return 'input required';
        }
        else{
          return null;
        }
      },
      controller: controller == emailController ? emailController: passwordController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: InputBorder.none,
        prefixIcon: hintText == "البريد الإلكتروني" ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == "كلمة السر" ? IconButton(
          onPressed: _toggleVisibility,
          icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        ) : null,
      ),
      obscureText: hintText == "كلمة السر" ? _isHidden : false,
    );
  }

}


import 'package:bc_app/providers/authProvider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
    var progressDialog = ProgressDialog(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFF1F4F7),
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  /// logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo3d.png', height: 250,),
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
                                child: buildTextField("اسم المستخدم", emailController),
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
                          FocusScope.of(context).requestFocus(FocusNode());
                          if(_key.currentState.validate()){
                            _key.currentState.save();
                            progressDialog.show();
                            bool login = await authProvider.login(emailController.text, passwordController.text);
                            if(login){
                              progressDialog.hide();
                              Navigator.of(context).pushReplacementNamed('home');
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                message:  "تسجيل الدخول",
                                duration:  Duration(seconds: 3),
                              )..show(context);
                            }else{
                              progressDialog.hide();
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Colors.red,
                                message:  "اسم المستخدم أو كلمة المرور غير صحيحة",
                                duration:  Duration(seconds: 3),
                              )..show(context);
                            }


                          }
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
                  SizedBox(height: 20.0,),
                  Column(
                    children: [
                      Center(
                        child: ButtonTheme(
                          height: 50.0,
                          child: RaisedButton(
                            shape: CircleBorder(),
                            onPressed: () {
                              Navigator.of(context).pushNamed('be_a_seller');
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
          return 'ادخل الحقل';
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
        prefixIcon: hintText == "اسم المستخدم" ? Icon(Icons.person) : Icon(Icons.lock),
        suffixIcon: hintText == "كلمة السر" ? IconButton(
          onPressed: _toggleVisibility,
          icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        ) : null,
      ),
      obscureText: hintText == "كلمة السر" ? _isHidden : false,
    );
  }

}


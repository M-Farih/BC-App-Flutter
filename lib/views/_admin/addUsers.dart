import 'package:another_flushbar/flushbar.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/views/widgets/appbar.dart';
import 'package:bc_app/views/widgets/profilInfoBtn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final _key = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final telephoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int role_id = await Provider.of<AuthProvider>(context, listen: false)
          .checkLoginAndRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    var userProvider = Provider.of<UserProvider>(context, listen: true);
    var progressDialog = ProgressDialog(context);
    return Scaffold(
      appBar: MyAppBar(
          isSeller: authProvider.currentUsr.idrole == 3 ? true : false,
          roleId: authProvider.currentUsr.idrole),
      body: SingleChildScrollView(
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
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
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
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),

              /// title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ajouter un nouvel administrateur', style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 30),

              /// Form
              Form(
                key: _key,
                child: Column(
                  children: [

                    /// nom & prenom
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildTextField("Nom", nomController),
                                ),
                              )
                          ),
                          Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildTextField(
                                      "Prénom", prenomController),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),

                    /// username & password
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildTextField(
                                      "Username", usernameController),
                                ),
                              )
                          ),
                          Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildTextField(
                                      "Password", passwordController),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),

                    /// Email
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildTextField("Email", emailController),
                          )
                      ),
                    ),

                    /// Telephone
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                      child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildTextField("Téléphone",
                                telephoneController),
                          )
                      ),
                    ),


                    /// btn add
                    GestureDetector(
                      child: ProfilInfoBtn(
                        text: 'Ajouter',
                        textColor: 0xFFFFFFFF,
                        color: 0xFF2C7DBF,
                        btnHeight: 50,
                        btnWidth: 120,
                      ),
                      onTap: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          progressDialog.show();
                          userProvider.add(
                              nomController.text, prenomController.text,
                              usernameController.text, passwordController.text,
                              emailController.text, telephoneController.text
                          ).whenComplete(() {
                            progressDialog.hide();
                            Flushbar(
                              message: 'Admin ajouté',
                              duration: Duration(seconds: 3),
                            )
                              ..show(context);

                            nomController.text = "";
                            prenomController.text = "";
                            usernameController.text = "";
                            passwordController.text = "";
                            emailController.text = "";
                            telephoneController.text = "";
                          });
                        }
                        else
                          print('is not validate');
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, controller) {
    var myController = TextEditingController();
    IconData myIcon;
    TextInputType myTextInputType;

    switch (hintText) {
      case 'Nom':
        myController = nomController;
        myIcon = Icons.person;
        myTextInputType = TextInputType.text;
        break;
      case 'Prénom':
        myController = prenomController;
        myIcon = Icons.person;
        myTextInputType = TextInputType.text;
        break;
      case 'Username':
        myController = usernameController;
        myIcon = Icons.account_circle;
        myTextInputType = TextInputType.text;
        break;
      case 'Password':
        myController = passwordController;
        myIcon = Icons.lock;
        myTextInputType = TextInputType.text;
        break;
      case 'Email':
        myController = emailController;
        myIcon = Icons.mail;
        myTextInputType = TextInputType.emailAddress;
        break;
      case 'Téléphone':
        myController = telephoneController;
        myIcon = Icons.phone_android;
        myTextInputType = TextInputType.phone;
        break;
    }

    return TextFormField(
      validator: (v) {
        if (v.isEmpty) {
          return 'champs obligatoir';
        }
        else {
          return null;
        }
      },
      controller: myController,
      keyboardType: myTextInputType,
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

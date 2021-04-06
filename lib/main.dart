import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/home/homePage.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  ///check if user is logged in
  AuthentificationService as = AuthentificationService();
  //var loginStatus = await as.checkLogin();
  var loginStatus = true;

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFF1F4F7)),
      home: loginStatus == false ? LoginPage() : HomePage()),
  );
}


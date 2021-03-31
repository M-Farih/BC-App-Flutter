import 'package:bc_app/services/authentificationService.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loginStatus = prefs.getBool('isLogged');
  print("Login status: $loginStatus");
  runApp(MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFF1F4F7)),
      home: loginStatus == null ? LoginPage() : HomePage())
  );
  //runApp(MaterialApp(home: HomePage()));
}


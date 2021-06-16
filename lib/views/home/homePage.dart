import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/testtt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _role_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      _role_id = await Provider.of<AuthProvider>(context, listen: false).checkLoginAndRole();
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
        body: authProvider.userChekcerIsBusy
            ?Center(child: Text('home page...'))
            :Center(
            child:
                  _role_id == 1 ?HomePage_admin()
                :_role_id == 2 ?HomePage_Commercial()
                :_role_id == 3 ?HomePage_Revendeur()
                :_role_id == 0 ?HomePage_admin()
                :LoginPage())
      );
  }
}



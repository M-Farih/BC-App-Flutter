import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/views/_admin/home/homePage_admin.dart';
import 'package:bc_app/views/_commercial/home/homePage_commercial.dart';
import 'package:bc_app/views/_revendeur/home/homePage_revendeur.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/roleTest/adminT.dart';
import 'package:bc_app/views/roleTest/commT.dart';
import 'package:bc_app/views/roleTest/sellerP.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      int role_id = await Provider.of<AuthProvider>(context, listen: false).checkLoginAndRole();

      switch(role_id){
        case 0:
          print('super admin');
          break;
        case 1:
          print('admin');
          break;
        case 2:
          print('commercial');
          break;
        case 3:
          print('revendeur');
          break;
        default:
          Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
        body: authProvider.busy
            ?Center(child: CircularProgressIndicator())
            :Center(
            child:
            authProvider.currentUsr.idrole == 1 ?HomePage_admin()
                :authProvider.currentUsr.idrole == 2 ?HomePage_Commercial()
                :authProvider.currentUsr.idrole == 3 ?HomePage_Revendeur()
                :authProvider.currentUsr.idrole == 0 ?HomePage_admin()
                :LoginPage())
      );
  }
}



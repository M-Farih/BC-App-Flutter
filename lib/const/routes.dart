import 'package:bc_app/views/_admin/addUsers.dart';
import 'package:bc_app/views/_admin/ristournePage.dart';
import 'package:bc_app/views/_commercial/sellers/sellerDetails.dart';
import 'package:bc_app/views/_revendeur/profil/profilPage.dart';
import 'package:bc_app/views/_revendeur/sugg_recl/ReclamationDetails.dart';
import 'package:bc_app/views/authentification/loginPage.dart';
import 'package:bc_app/views/home/homePage.dart';
import 'package:bc_app/views/product/productAdd.dart';
import 'package:bc_app/views/product/promotionAdd.dart';
import 'package:bc_app/views/revendeur/beASeller.dart';
import 'package:bc_app/views/testtt.dart';
import 'file:///C:/_myproject/flutter/BC-App-Flutter/lib/views/_revendeur/sugg_recl/listReclamation.dart';
import 'file:///C:/_myproject/flutter/BC-App-Flutter/lib/views/_revendeur/sugg_recl/reclamation.dart';
import 'package:flutter/material.dart';

const String initialRoute = "home";

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'be_a_seller':
        return MaterialPageRoute(builder: (_) => BeASeller());
      case 'reclamation':
        return MaterialPageRoute(builder: (_) => ReclamationPage());
      case 'list_reclamation':
        return MaterialPageRoute(builder: (_) => ListReclamation());
      case 'reclamation_details':
        return MaterialPageRoute(builder: (_) => ReclamationDetails());
      case 'seller_details':
        return MaterialPageRoute(builder: (_) => SellerDetails());
      case 'profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case 'add-product':
        return MaterialPageRoute(builder: (_) => ProductAdd());
      case 'add-promotion':
        return MaterialPageRoute(builder: (_) => PromotionAdd());
      case 'add-user':
        return MaterialPageRoute(builder: (_) => AddUser());
      case 'ristourne-page':
        return MaterialPageRoute(builder: (_) => RistournePage());

      default: return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          )
      );
    }
  }
}
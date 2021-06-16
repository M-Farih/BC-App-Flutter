import 'package:bc_app/const/routes.dart';
import 'package:bc_app/providers/authProvider.dart';
import 'package:bc_app/providers/commentProvider.dart';
import 'package:bc_app/providers/contactProvider.dart';
import 'package:bc_app/providers/nombre_total_revendeur_provider.dart';
import 'package:bc_app/providers/productProvider.dart';
import 'package:bc_app/providers/promotionProvider.dart';
import 'package:bc_app/providers/reasonProvider.dart';
import 'package:bc_app/providers/ristourneProvider.dart';
import 'package:bc_app/providers/topicProvider.dart';
import 'package:bc_app/providers/userProvider.dart';
import 'package:bc_app/providers/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  return runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:
        [
          ChangeNotifierProvider(
              create: (context) => locator<AuthProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<UserProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<ContactProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<ReasonProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<TopicProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<CommentProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<NombreTotalRevendeurProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<ProductProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<PromotionProvider>()
          ),
          ChangeNotifierProvider(
              create: (context) => locator<RistourneProvider>()
          ),
        ],
        child: StartApp()
    );
  }
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BC APP',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
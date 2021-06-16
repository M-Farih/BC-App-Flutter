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
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerFactory(() => AuthProvider());
  locator.registerFactory(() => UserProvider());
  locator.registerFactory(() => ContactProvider());
  locator.registerFactory(() => ReasonProvider());
  locator.registerFactory(() => TopicProvider());
  locator.registerFactory(() => CommentProvider());
  locator.registerFactory(() => NombreTotalRevendeurProvider());
  locator.registerFactory(() => ProductProvider());
  locator.registerFactory(() => PromotionProvider());
  locator.registerFactory(() => RistourneProvider());
}
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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}


Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

class StartApp extends StatefulWidget {

  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
    FirebaseMessaging.instance.getToken().then((value) => print('token key  $value'));

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      Provider.of<AuthProvider>(context, listen: false).getUserFromSP();
    });
  }

  void showNotification() {

    flutterLocalNotificationsPlugin.show(
        0,
        "Testing...",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name, channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }


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
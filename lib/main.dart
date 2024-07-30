import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:deliverydriver/controller/auth_controller.dart';
import 'package:deliverydriver/controller/home_controller.dart';
import 'package:deliverydriver/controller/map_controller.dart';
import 'package:deliverydriver/controller/notification_controller.dart';
import 'package:deliverydriver/controller/order_controller.dart';
import 'package:deliverydriver/controller/review_controller.dart';
import 'package:deliverydriver/controller/shared_controller.dart';
import 'package:deliverydriver/controller/wallet_controller.dart';
import 'package:deliverydriver/view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:deliverydriver/class/global.dart' as global;
import 'package:location/location.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
late AndroidNotificationChannel? channel;
late FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'mg_notification_center', // id
      'MG Notification Center', // title
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HKShip Tài xế',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: global.gold),
        useMaterial3: true,
      ),
      home: const AppView(),
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final PageStorageBucket bucket=PageStorageBucket();
  Widget currentView=const LoginView();
  final authController=Get.put(AuthController());
  final notificationController=Get.put(NotificationController());
  final orderController=Get.put(OrderController());
  final mapController=Get.put(MapController());
  final reviewController=Get.put(ReviewController());
  final walletController=Get.put(WalletController());
  final homeController=Get.put(HomeController());
  final sharedController=Get.put(SharedController());
  //
  Location location = Location();

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                icon: '@mipmap/ic_launcher'
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    super.initState();
    checkLocation();
    checkNotificationPermission();
  }

  checkNotificationPermission() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> checkLocation() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    else{
      return;
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentView,
      ),
    );
  }
}


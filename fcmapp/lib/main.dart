import 'dart:async';
import 'dart:ui';

import 'package:fcmapp/Services/FirebaseServices.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

import 'HomeScreen.dart';
import 'firebase_options.dart';



// For Creating Notification Channel
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'Alerts', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);


//Notification Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Calback 1");
  print('A bg message just showed up :  ${message.messageId}');
  //  Fluttertoast.showToast(msg: "DDDD"+message.notification.toString());
  print("Notification Click>>>>>>>>>>> Background $message");

  print("Click >>>>>>>>>>>>>>>>>> 3 $message");
  print('Got a message wishlist in the foreground!');
  print('Message data: ${message.data}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    print("flutterLocalNotificationsPlugin 1 ");
    // flutterLocalNotificationsPlugin.show(
    //   notification.hashCode,
    //   notification.title,
    //   notification.body,
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       channel.id,
    //       channel.name,
    //       channelDescription: channel.description,
    //       color: Colors.blue,
    //       playSound: true,
    //       icon: '@mipmap/ic_launcher',
    //     ),
    //   ),
    //   payload: message.data.toString(),
    // );

    // showNotification(notification, android, message.data);
  }


  try{



  }catch(e)
  {
    print("MyJsonGGGG  $e");
  }





}
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();

void main() async  {

  WidgetsFlutterBinding.ensureInitialized();

  Get.put(MyRedirectionService());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );




  FirebaseMessaging.instance.getToken().then((value) {
    String? token = value;

    print(">>>>>>>>>>>>>> $token");
  });



  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );



  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    // notificationCategories: darwinNotificationCategories,
  );

  final InitializationSettings initializationSettingss = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,

  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettingss,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      String? Data = notificationResponse.payload;
      print("Calback 2"+notificationResponse.payload.toString());

      Get.find<MyRedirectionService>().onReceivedData(notificationResponse.payload.toString());
      print("New >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ${notificationResponse.payload}");

      //   Fluttertoast.showToast(msg: "FFFFFF");



      // var json = jsonEncode(notificationResponse.payload.toString());
      //
      // print("Notification Json " + json);

      // Map<String, dynamic> notificationData = jsonDecode(json);
      // //
      // // // Now you can access individual fields using keys
      // String Id = notificationData['type_id'];
      // String description = notificationData['description'];
      // String action = notificationData['action'];
      // String notificationId = notificationData['notification_id'];
      // String body = notificationData['body'];
      // String type = notificationData['type'];
      // String title = notificationData['title'];
      // //
      // print("Id : " + Id);
      // print("description : " + description);
      // print("action : " + action);
      // print("notificationId : " + notificationId);
      // print("body : " + body);
      // print("type : " + type);
      // print("title : " + title);
      // //   }



      // print(notificationResponse.payload);
      // print(notificationResponse.id);
      // print(notificationResponse.actionId);
      // print(notificationResponse.payload?.isEmpty);
    },

  );


  // Gaurav For terminate Notification message Recieve

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  final didNotificationLaunchApp =
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;



// FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    Permission.notification.isDenied.then((value)  {
      if (value) {
        print('Permission nn Status '+value.toString());
        Permission.notification.request();
        Permission.notification.request().isGranted.then((value){

        });
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print("**********");
      print("Calback 3"+value!.data.toString());
      Get.find<MyRedirectionService>().onReceivedData(value!.data.toString());


    });



    // FirebaseMessaging.instance.getInitialMessage().then((value) {
    //   print("Calback 3");
    //   print("Notification click >>>>>>>>>>>>>>>>>>>>>>>>.");
    //   print('getInitialMessage data: $value');
    //
    //   //  Fluttertoast.showToast(msg: "AAAAA"+value.toString());
    //
    //
    // });




    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Calback 4");
      //print("Click >>>>>>>>>>>>>>>>>> 1 "+jsonEncode(message));
      print("Click >>>>>>>>>>>>>>>>>> 1 ${message}");
      RemoteNotification? notification = message.notification;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification!.title,
        notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: message.data.toString(),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("Calback 5 "+message.data.toString());

      Get.find<MyRedirectionService>().onReceivedData(message.data!.toString());
      print("Click >>>>>>>>>>>>>>>>>> 2");
      //   Fluttertoast.showToast(msg: "CCCCC");
      print('Got a message wishlist in the foreground!');
      print('Message data: ${message.data}');







    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async  {
      print("Calback 6");
      print("Click >>>>>>>>>>>>>>>>>> 3");
      print('Got a message wishlist in the foreground!');
      print('Message data: ${message.data}');
      //   Fluttertoast.showToast(msg: "******");



      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print("flutterLocalNotificationsPlugin 4 ");
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: message.data.toString(),
        );

        // showNotification(notification, android, message.data);
      }

      print("onMessage data:GGGG 1 ${message.data}");
    });


    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}




class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
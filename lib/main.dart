import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hosomobile/features/language/controllers/localization_controller.dart';
import 'package:hosomobile/features/school/controllers/cart_controller.dart';
import 'package:hosomobile/features/setting/controllers/theme_controller.dart';
import 'package:hosomobile/helper/notification_helper.dart';
import 'package:hosomobile/helper/route_helper.dart';
import 'package:hosomobile/theme/dark_theme.dart';
import 'package:hosomobile/theme/light_theme.dart';
import 'package:hosomobile/util/app_constants.dart';
import 'package:hosomobile/util/messages.dart';
import 'helper/get_di.dart' as di;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
 late List<CameraDescription> cameras;

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {

 WidgetsFlutterBinding.ensureInitialized();
 HttpOverrides.global = MyHttpOverrides();

    // Initialize Firebase with web options if on the web
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyCwZRTO3ydX4lAKIaplZbAndfzxxqbhbWI",
            authDomain: "hosomobile-app.firebaseapp.com",
            projectId: "hosomobile-app",
            storageBucket: "hosomobile-app.firebasestorage.app",
            messagingSenderId: "908377002813",
            appId: "1:908377002813:web:b4727e19759cd2424d2b54",
          )
        : null,
  );

if (!kIsWeb) {
    await FirebaseMessaging.instance.requestPermission();
    await NotificationHelper.initialize(FlutterLocalNotificationsPlugin());
  }

  ///firebase crashlytics


  
 if (!kIsWeb) {
  cameras = await availableCameras();
}

  Map<String, Map<String, String>> languages = await di.init();

  int? orderID;
 // NotificationBody? body;
  try {
    final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      //body = NotificationHelper.convertNotification(remoteMessage.data);
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }catch(e) {
    if (kDebugMode) {
      print("");
    }
  }

  runApp(MyApp(languages: languages, orderID: orderID));

}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  final int? orderID;
  const MyApp({super.key, required this.languages, required this.orderID});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {

      //   MaterialApp(
      //     debugShowCheckedModeBanner: false,
      //         theme: ThemeData(
      //   // Define the default font family.
      //   fontFamily: 'Roboto', // default for Android
      //   textTheme: TextTheme(
      //     bodyLarge: GoogleFonts.roboto(),
      //     bodySmall: GoogleFonts.roboto(),
      //     bodyMedium: GoogleFonts.roboto(),
      //     titleSmall: GoogleFonts.roboto(),
      //     titleLarge: GoogleFonts.roboto(),
      //     titleMedium: GoogleFonts.roboto()
      //   ),
      // ),
      //     home:HosoHomeScreen()
      //   ) ;
    
        return     
        MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
          child: GetMaterialApp(
             initialBinding: CartBinding(), // Add this
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
            initialRoute: RouteHelper.getSplashRoute(),
            getPages: RouteHelper.routes,
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      );
    },
    );
  }
}

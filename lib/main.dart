import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:LoveBirds/localization/localizations_delegate.dart';
import 'package:LoveBirds/routes/app_pages.dart';
import 'package:LoveBirds/routes/app_routes.dart';
import 'package:LoveBirds/utils/colors_utils.dart';
import 'package:LoveBirds/utils/database.dart';
import 'package:LoveBirds/utils/internet_connection.dart';
import 'package:LoveBirds/utils/notification_services.dart';
import 'package:LoveBirds/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:permission_handler/permission_handler.dart';

AppLifecycleState? currentAppLifecycleState;

/// IMPORTANT:
/// The background handler must be a top-level function and registered BEFORE runApp.
/// We register it in NotificationServices.init() which sets FirebaseMessaging.onBackgroundMessage.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  try {
    await Firebase.initializeApp();
  } catch (e) {
    Utils.showLog('Firebase initialization error: $e');
  }

  await GetStorage.init();
  InternetConnection.init();

  if (Database.isAutoRefreshEnabled == false) {
    Database.onSetIsLiveStreamApiCall(true);
    Database.onSetIsMessageApiCall(true);
    Database.onSetIsHostLiveStreamApiCall(true);
    Database.onSetIsHostMessageApiCall(true);
  }

  await onRequestPermissions();

  Utils.onChangeStatusBar(brightness: Brightness.light);

  // Initialize notification services (this will also register background handler).
  await NotificationServices.init();

  runApp(const MyApp());
}

Future<void> onRequestPermissions() async {
  await Permission.camera.request();
  await Permission.microphone.request();
  // Ask local notification permission (AwesomeNotifications) if you want here as well
  // but NotificationServices.init handles AwesomeNotifications permission.
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final StreamController purchaseStreamController =
      StreamController<PurchaseDetails>.broadcast();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    currentAppLifecycleState = state;

    Utils.showLog('AppLifecycleState changed to: $state');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(Database.selectedLanguageCode),
      translations: AppLanguages(),
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
      ),
      initialRoute: AppRoutes.splashScreenPage,
      getPages: AppPages.list,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}

// import 'dart:math';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:figgy/main.dart';
// import 'package:figgy/routes/app_routes.dart';
// import 'package:figgy/socket/socket_emit.dart';
// import 'package:figgy/utils/api_params.dart';
// import 'package:figgy/utils/database.dart';
// import 'package:figgy/utils/utils.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class NotificationServices {
//   static FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   static Future<void> init() async {
//     await initAwesomeNotifications();
//     await ensurePushPermission();
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onAwesomeNotificationActionReceived,
//     );
//     await firebaseInit();
//   }
//
//   static Future<void> firebaseInit() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final dataType = message.data['type']?.toString();
//       if (dataType == null) return;
//
//       final isOnChat = Get.currentRoute == AppRoutes.chatPage;
//       final isChatMessage = dataType == 'CHAT';
//       final isCallIncoming = dataType == 'callIncoming';
//       final isCall = dataType == 'CALL';
//
//       if (isChatMessage && isOnChat) {
//         Utils.showLog("🔕 Chat screen visible; suppressing chat notification.");
//         return;
//       }
//
//       if (isCallIncoming || isCall) {
//         if (currentAppLifecycleState == AppLifecycleState.paused) {
//           Utils.showLog("Showing incoming call notification");
//
//           showAwesomeNotification(message);
//         }
//       } else {
//         // Show notification for all users and hosts (except fake senders to hosts)
//         if (!Database.isHost) {
//           showAwesomeNotification(message);
//         } else {
//           // For hosts: show notification unless it's from a fake sender
//           final isFakeSender = message.data["isFakeSender"] == true;
//           if (!isFakeSender) {
//             showAwesomeNotification(message);
//           }
//         }
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage m) {
//       navigateFromData(m.data);
//     });
//
//     final initial = await messaging.getInitialMessage();
//     if (initial != null) {
//       navigateFromData(initial.data);
//     }
//
//     FirebaseMessaging.onBackgroundMessage(backgroundNotification);
//   }
//
//   static Future<void> onAwesomeNotificationActionReceived(ReceivedAction action) async {
//     Utils.showLog("🔔 Action: ${action.buttonKeyPressed}");
//
//     final payload = action.payload ?? const {};
//     final key = action.buttonKeyPressed ?? '';
//
//     if (key == 'ACCEPT' || key == 'DECLINE') {
//       final isAccept = key == 'ACCEPT';
//       await AwesomeNotifications().dismiss(action.id ?? 0);
//
//       SocketEmit.onCallAcceptOrDecline(
//         callerId: payload["callerId"] ?? "",
//         receiverId: payload["receiverId"] ?? "",
//         callId: payload["callId"] ?? "",
//         isAccept: isAccept,
//         callType: payload["callType"] ?? "",
//         callMode: payload["callMode"] ?? "",
//         receiverImage: payload["receiverImage"] ?? "",
//         receiverName: payload["receiverName"] ?? "",
//         senderImage: payload["callerImage"] ?? "",
//         senderName: payload["callerName"] ?? "",
//         token: payload["token"] ?? "",
//         channel: payload["channel"] ?? "",
//         gender: payload["gender"] ?? "",
//         callerUniqueId: payload["callerUniqueId"] ?? "",
//         receiverUniqueId: payload["receiverUniqueId"] ?? "",
//         callerRole: "user",
//         receiverRole: "host",
//       );
//       return;
//     }
//
//     navigateFromData(payload);
//   }
//
//   static Future<void> showAwesomeNotification(RemoteMessage message) async {
//     final allowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!allowed) {
//       final granted = await AwesomeNotifications().requestPermissionToSendNotifications();
//       if (granted != true) {
//         Utils.showLog("❌ Local notification permission denied.");
//         return;
//       }
//     }
//
//     final data = message.data;
//     final title = (data['title'] ?? message.notification?.title ?? 'New notification') // safe default
//         .toString();
//     final body = (data['body'] ?? message.notification?.body ?? defaultBodyForType(data['type']?.toString())).toString();
//
//     final type = data['type']?.toString() ?? '';
//     String channelKey = 'chat_channel';
//     NotificationCategory category = NotificationCategory.Message;
//     List<NotificationActionButton> actions = [];
//
//     if (type == 'CALL' || type == 'callIncoming') {
//       channelKey = 'call_channel';
//       category = NotificationCategory.Call;
//       actions = [
//         NotificationActionButton(key: 'ACCEPT', label: 'Accept'),
//         NotificationActionButton(key: 'DECLINE', label: 'Decline'),
//       ];
//     } else if (type == 'LIVE') {
//       channelKey = 'live_channel';
//       category = NotificationCategory.Social;
//     } else if (type == 'GIFT') {
//       channelKey = 'chat_channel';
//       category = NotificationCategory.Social;
//     }
//
//     final stableId = stableIdFrom(data['callId'] ?? data['channel']);
//
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: stableId ?? Random.secure().nextInt(1 << 31),
//         channelKey: channelKey,
//         title: title,
//         body: body,
//         category: category,
//         icon: 'resource://mipmap/ic_notification',
//         payload: data.map((k, v) => MapEntry(k.toString(), v.toString())),
//         notificationLayout: NotificationLayout.Default,
//         displayOnForeground: true,
//         displayOnBackground: true,
//         wakeUpScreen: (channelKey == 'call_channel'),
//         fullScreenIntent: (channelKey == 'call_channel'),
//         criticalAlert: (channelKey == 'call_channel'),
//         autoDismissible: (channelKey != 'call_channel'),
//         timeoutAfter: null,
//       ),
//       actionButtons: actions,
//     );
//   }
//
//   static Future<void> initAwesomeNotifications() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'call_channel',
//           channelName: 'Call Channel',
//           channelDescription: 'Incoming call notifications',
//           defaultColor: Colors.green,
//           importance: NotificationImportance.Max,
//           locked: true,
//           playSound: true,
//           enableVibration: true,
//           criticalAlerts: true,
//         ),
//         NotificationChannel(
//           channelKey: 'chat_channel',
//           channelName: 'Chat Channel',
//           channelDescription: 'Chat & gift notifications',
//           defaultColor: Colors.blue,
//           importance: NotificationImportance.High,
//           playSound: true,
//           enableVibration: true,
//         ),
//         NotificationChannel(
//           channelKey: 'live_channel',
//           channelName: 'Live Channel',
//           channelDescription: 'Live stream notifications',
//           defaultColor: Colors.red,
//           importance: NotificationImportance.High,
//           playSound: true,
//           enableVibration: true,
//         ),
//       ],
//       debug: false,
//     );
//
//     if (!await AwesomeNotifications().isNotificationAllowed()) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   }
//
//   static Future<void> ensurePushPermission() async {
//     final settings = await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: true,
//       provisional: false,
//       sound: true,
//     );
//     final granted = settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional;
//
//     if (!granted) {
//       Utils.showLog("❌ Push permission not granted.");
//     }
//   }
//
//   static void navigateFromData(Map<String, dynamic> data) {
//     final type = data[ApiParams.type]?.toString();
//
//     if (type == "CHAT" || type == "GIFT") {
//       if (data[ApiParams.senderRole]?.toString() == "host") {
//         Get.toNamed(AppRoutes.chatPage, arguments: {
//           ApiParams.hostId: data[ApiParams.senderId],
//           ApiParams.receiverId: data[ApiParams.receiverId],
//           ApiParams.hostName: data[ApiParams.userName],
//           ApiParams.profileImage: data[ApiParams.userImage],
//           ApiParams.isChatHostDetail: false,
//         });
//       } else {
//         Get.toNamed(AppRoutes.chatPage, arguments: {
//           ApiParams.senderId: data[ApiParams.senderId],
//           ApiParams.receiverId: data[ApiParams.receiverId],
//           ApiParams.hostName: data[ApiParams.userName],
//           ApiParams.profileImage: data[ApiParams.userImage],
//           ApiParams.isChatHostDetail: false,
//         });
//       }
//       return;
//     }
//
//     if (type == "LIVE") {
//       Get.toNamed(AppRoutes.hostLivePage, arguments: {
//         ApiParams.isHost: false,
//         ApiParams.name: data[ApiParams.name],
//         ApiParams.image: data[ApiParams.image],
//         ApiParams.liveHistoryId: data[ApiParams.liveHistoryId],
//         ApiParams.hostId: data[ApiParams.hostId],
//         ApiParams.token: data[ApiParams.token],
//         ApiParams.channel: data[ApiParams.channel],
//       });
//       return;
//     }
//   }
//
//   static String defaultBodyForType(String? type) {
//     switch (type) {
//       case 'CALL':
//       case 'callIncoming':
//         return 'Incoming call';
//       case 'LIVE':
//         return 'A live stream has started';
//       case 'GIFT':
//         return 'You received a gift';
//       case 'CHAT':
//         return 'You have a new message';
//       default:
//         return 'You have a new notification';
//     }
//   }
//
//   static int? stableIdFrom(dynamic v) {
//     if (v == null) return null;
//     final s = v.toString();
//     return s.codeUnits.fold<int>(0, (a, b) => ((a * 31) ^ b) & 0x7fffffff);
//   }
// }
//
// ///****************** Background Notification
// @pragma('vm:entry-point')
// Future<void> backgroundNotification(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   await NotificationServices.showAwesomeNotification(message);
// }


// notification_services.dart




import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:figgy/main.dart';
import 'package:figgy/routes/app_routes.dart';
import 'package:figgy/socket/socket_emit.dart';
import 'package:figgy/utils/api_params.dart';
import 'package:figgy/utils/database.dart';
import 'package:figgy/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationServices {
  static final FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// Call this once at app startup (before runApp ideally)
  static Future<void> init() async {
    await initAwesomeNotifications();
    await ensurePushPermission();
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(backgroundNotification);

    await firebaseInit();
  }

  /// Initialize awesome notification channels & request permission for local notifications
  static Future<void> initAwesomeNotifications() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'call_channel',
          channelName: 'Call Channel',
          channelDescription: 'Incoming call notifications',
          defaultColor: Colors.green,
          importance: NotificationImportance.Max,
          locked: true,
          playSound: true,
          enableVibration: true,
          criticalAlerts: true,
        ),
        NotificationChannel(
          channelKey: 'chat_channel',
          channelName: 'Chat Channel',
          channelDescription: 'Chat & gift notifications',
          defaultColor: Colors.blue,
          importance: NotificationImportance.High,
          playSound: true,
          enableVibration: true,
        ),
        NotificationChannel(
          channelKey: 'live_channel',
          channelName: 'Live Channel',
          channelDescription: 'Live stream notifications',
          defaultColor: Colors.red,
          importance: NotificationImportance.High,
          playSound: true,
          enableVibration: true,
        ),
      ],
      debug: false,
    );

    final allowed = await AwesomeNotifications().isNotificationAllowed();
    if (!allowed) {
      final granted = await AwesomeNotifications().requestPermissionToSendNotifications();
      Utils.showLog('AwesomeNotification local permission granted: $granted');
    }

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onAwesomeNotificationActionReceived,
    );
  }

  /// Request FCM push permission (iOS)
  static Future<void> ensurePushPermission() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    final granted = settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional;
    if (!granted) {
      Utils.showLog("❌ Push permission not granted.");
    } else {
      Utils.showLog("✅ Push permission granted: ${settings.authorizationStatus}");
    }
  }

  /// Setup runtime listeners for foreground & interaction
  static Future<void> firebaseInit() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {
        final data = _normalizeDataMap(message.data);
        final dataTypeRaw = data['type'] ?? data['notificationType'] ?? data['category'];
        final dataType = (dataTypeRaw ?? '').toString();

        final bool noUsefulData = data.isEmpty && message.notification == null;
        if (noUsefulData) {
          Utils.showLog('⚠️ Empty push received, ignoring.');
          return;
        }

        final isOnChat = Get.currentRoute == AppRoutes.chatPage;
        final upperType = dataType.toUpperCase();

        final isChatMessage = upperType == 'CHAT';
        final isCallIncoming = dataType == 'callIncoming';
        final isCall = upperType == 'CALL';

        if (isChatMessage && isOnChat) {
          Utils.showLog("🔕 Chat screen visible; suppressing chat notification.");
          return;
        }

        if (isCallIncoming || isCall) {
          if (currentAppLifecycleState == AppLifecycleState.paused ||
              currentAppLifecycleState == AppLifecycleState.inactive) {
            Utils.showLog("Showing incoming call notification (foreground listener detected background state).");
            await showAwesomeNotification(message);
            return;
          } else {
            await showAwesomeNotification(message);
            return;
          }
        }

        if (!Database.isHost) {
          await showAwesomeNotification(message);
        } else {
          final isFakeSenderRaw = data["isFakeSender"];
          final isFakeSender = _toBool(isFakeSenderRaw);
          if (!isFakeSender) {
            await showAwesomeNotification(message);
          } else {
            Utils.showLog("Filtered fake sender notification for host.");
          }
        }
      } catch (e, st) {
        Utils.showLog("Error in onMessage listener: $e\n$st");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage m) {
      navigateFromData(_normalizeDataMap(m.data));
    });

    final initial = await messaging.getInitialMessage();
    if (initial != null) {
      navigateFromData(_normalizeDataMap(initial.data));
    }
  }


  /// Called by AwesomeNotifications when a button is pressed
  static Future<void> onAwesomeNotificationActionReceived(ReceivedAction action) async {
    Utils.showLog("🔔 Action: ${action.buttonKeyPressed}");

    final payload = action.payload ?? const {};
    final key = action.buttonKeyPressed ?? '';

    if (key == 'ACCEPT' || key == 'DECLINE') {
      final isAccept = key == 'ACCEPT';
      await AwesomeNotifications().dismiss(action.id ?? 0);

      SocketEmit.onCallAcceptOrDecline(
        callerId: payload["callerId"] ?? "",
        receiverId: payload["receiverId"] ?? "",
        callId: payload["callId"] ?? "",
        isAccept: isAccept,
        callType: payload["callType"] ?? "",
        callMode: payload["callMode"] ?? "",
        receiverImage: payload["receiverImage"] ?? "",
        receiverName: payload["receiverName"] ?? "",
        senderImage: payload["callerImage"] ?? "",
        senderName: payload["callerName"] ?? "",
        token: payload["token"] ?? "",
        channel: payload["channel"] ?? "",
        gender: payload["gender"] ?? "",
        callerUniqueId: payload["callerUniqueId"] ?? "",
        receiverUniqueId: payload["receiverUniqueId"] ?? "",
        callerRole: "user",
        receiverRole: "host",
      );
      return;
    }

    navigateFromData(_normalizeDataMap(payload));
  }

  /// Display a local notification using AwesomeNotifications
  static Future<void> showAwesomeNotification(RemoteMessage message) async {
    final allowed = await AwesomeNotifications().isNotificationAllowed();
    if (!allowed) {
      final granted = await AwesomeNotifications().requestPermissionToSendNotifications();
      if (granted != true) {
        Utils.showLog("❌ Local notification permission denied.");
        return;
      }
    }

    final data = _normalizeDataMap(message.data);
    final title = (data['title'] ?? message.notification?.title ?? 'New notification').toString();
    final body = (data['body'] ?? message.notification?.body ?? defaultBodyForType(data['type']?.toString())).toString();

    final type = (data['type'] ?? '').toString();
    String channelKey = 'chat_channel';
    NotificationCategory category = NotificationCategory.Message;
    List<NotificationActionButton> actions = [];

    if (type.toUpperCase() == 'CALL' || type == 'callIncoming') {
      channelKey = 'call_channel';
      category = NotificationCategory.Call;
      actions = [
        NotificationActionButton(key: 'ACCEPT', label: 'Accept'),
        NotificationActionButton(key: 'DECLINE', label: 'Decline'),
      ];
    } else if (type.toUpperCase() == 'LIVE') {
      channelKey = 'live_channel';
      category = NotificationCategory.Social;
    } else if (type.toUpperCase() == 'GIFT') {
      channelKey = 'chat_channel';
      category = NotificationCategory.Social;
    }

    final stableId = stableIdFrom(data['callId'] ?? data['channel'] ?? data['id']);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: stableId ?? Random.secure().nextInt(1 << 31),
        channelKey: channelKey,
        title: title,
        body: body,
        category: category,
        icon: 'resource://mipmap/ic_notification',
        payload: data.map((k, v) => MapEntry(k.toString(), v.toString())),
        notificationLayout: NotificationLayout.Default,
        displayOnForeground: true,
        displayOnBackground: true,
        wakeUpScreen: (channelKey == 'call_channel'),
        fullScreenIntent: (channelKey == 'call_channel'),
        criticalAlert: (channelKey == 'call_channel'),
        autoDismissible: (channelKey != 'call_channel'),
        timeoutAfter: null,
      ),
      actionButtons: actions,
    );
  }

  /// Build navigation logic when tapping notification
  static void navigateFromData(Map<String, dynamic> data) {
    final type = data[ApiParams.type]?.toString();

    if (type == "CHAT" || type == "GIFT") {
      if (data[ApiParams.senderRole]?.toString() == "host") {
        Get.toNamed(AppRoutes.chatPage, arguments: {
          ApiParams.hostId: data[ApiParams.senderId],
          ApiParams.receiverId: data[ApiParams.receiverId],
          ApiParams.hostName: data[ApiParams.userName],
          ApiParams.profileImage: data[ApiParams.userImage],
          ApiParams.isChatHostDetail: false,
        });
      } else {
        Get.toNamed(AppRoutes.chatPage, arguments: {
          ApiParams.senderId: data[ApiParams.senderId],
          ApiParams.receiverId: data[ApiParams.receiverId],
          ApiParams.hostName: data[ApiParams.userName],
          ApiParams.profileImage: data[ApiParams.userImage],
          ApiParams.isChatHostDetail: false,
        });
      }
      return;
    }

    if (type == "LIVE") {
      Get.toNamed(AppRoutes.hostLivePage, arguments: {
        ApiParams.isHost: false,
        ApiParams.name: data[ApiParams.name],
        ApiParams.image: data[ApiParams.image],
        ApiParams.liveHistoryId: data[ApiParams.liveHistoryId],
        ApiParams.hostId: data[ApiParams.hostId],
        ApiParams.token: data[ApiParams.token],
        ApiParams.channel: data[ApiParams.channel],
      });
      return;
    }

    if (type == "CALL" || type == "callIncoming") {
      // open call screen or show incoming UI
      Get.toNamed(AppRoutes.chatPage); // adjust to your call page
      return;
    }
  }

  /// Default fallback bodies
  static String defaultBodyForType(String? type) {
    switch (type) {
      case 'CALL':
      case 'callIncoming':
        return 'Incoming call';
      case 'LIVE':
        return 'A live stream has started';
      case 'GIFT':
        return 'You received a gift';
      case 'CHAT':
        return 'You have a new message';
      default:
        return 'You have a new notification';
    }
  }

  /// Stable int id from a string (keeps notifications stable)
  static int? stableIdFrom(dynamic v) {
    if (v == null) return null;
    final s = v.toString();
    return s.codeUnits.fold<int>(0, (a, b) => ((a * 31) ^ b) & 0x7fffffff);
  }

  static Map<String, dynamic> _normalizeDataMap(Map<String, dynamic>? m) {
    if (m == null) return {};
    final Map<String, dynamic> out = {};
    m.forEach((k, v) {
      out[k.toString()] = v;
    });
    return out;
  }

  static bool _toBool(dynamic v) {
    if (v == null) return false;
    if (v is bool) return v;
    final s = v.toString().toLowerCase();
    return s == 'true' || s == '1' || s == 'yes';
  }
}

///****************** Background Notification
/// Must be top-level and annotated so the tree shaker doesn't remove it.
@pragma('vm:entry-point')
Future<void> backgroundNotification(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
  } catch (e) {
  }
  await NotificationServices.showAwesomeNotification(message);
}

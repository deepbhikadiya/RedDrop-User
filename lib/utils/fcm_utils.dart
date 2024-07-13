import 'package:ft_red_drop/package/config_packages.dart';
import 'package:ft_red_drop/package/screen_packages.dart';
import 'package:html/parser.dart';

class FCMUtils {
  FCMUtils._();

  static final FCMUtils instance = FCMUtils._();

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    enableVibration: true,
    playSound: true,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  setupChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  init(List<StreamSubscription> streams) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          debugPrint("FCMUtils: IOSInitializationSettings $id = $title -> $body -> $payload");
        });

    /// For handle manual notification click for foreground
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      ),
      onDidReceiveNotificationResponse: (notificationResponse) async {
        debugPrint("FCMUtils: initialize payload -> ${jsonDecode(notificationResponse.payload!)}");

        _handleNotification(jsonDecode(notificationResponse.payload!));
      },
    );

    /// only in Android when app is in foreground and need to show manual notification
    streams.add(FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("FCMUtils: onMessage -> ${message.notification?.title ?? ''} -> ${message.notification?.body ?? ''} -> ${message.data}");

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      RegExp exp = RegExp(r'<[^>]*>');
      String? subtitle;
      if (exp.hasMatch(notification?.body ?? "")) {
        var doc = parse(notification?.body);
        subtitle = doc.documentElement!.text;
      }
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            subtitle ?? notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: initializationSettingsAndroid.defaultIcon,
                styleInformation: BigTextStyleInformation(notification.body ?? ''),
                color: const Color(0xFFFFCE70),
              ),
            ),
            payload: jsonEncode(message.data));
        if (kDebugMode) {
          print("payload===>>>${jsonEncode(message.data)}");
        }
      }
    }));

    /// only when app is in background and notification click
    /// Android : only when app is in background
    /// iOS : foreground and background both
    streams.add(FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint("FCMUtils: onMessageOpenedApp -> ${message.notification?.title} -> ${message.notification?.body} -> ${message.data}");
        _handleNotification(message.data);
      },
    ));
    debugPrint("FCMUtils: token -> ${await getToken()}");
  }

  /// only when app is terminated and notification click
  checkHasAnyInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("background===================>" "FCMUtils: getInitialMessageData: fcm: ${message.data}");
        _handleNotification(message.data);
      }
    });

    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) {
      if (value != null) {
        if (value.didNotificationLaunchApp && value.notificationResponse?.payload != null) {
          debugPrint("FCMUtils: getInitialMessageData: local: ${value.notificationResponse?.payload}");
          _handleNotification(jsonDecode(value.notificationResponse?.payload ?? ""));
        }
      }
    });
  }

  Future<String?> getToken() => FirebaseMessaging.instance.getToken();

  Future<void> deleteToken() => FirebaseMessaging.instance.deleteToken();

  _handleNotification(Map<String, dynamic> data) async {
    if (data["notification_type"] == "blood_request") {
      Get.to(() => DonationReqDetailScreen(id: data['request_id']));
    } else if (data["notification_type"] == "request_accepted" || data["notification_type"] == "blood_donated") {
      Get.to(() => MyRequestDetailScreen(id: data['request_id']));
    } else if (data["notification_type"] == "donation_confirm") {
      Get.to(() => DonationReqDetailScreen(id: data['request_id']));
    } else if (data["notification_type"] == "login") {
      Get.offAllNamed(AppRouter.loginScreen);
    } else if (data["notification_type"] == "post") {
      Get.find<GlobalController>().selectedIndex.value = 1;
    }
  }
}

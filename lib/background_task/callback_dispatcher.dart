import 'package:call_away/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("userId from callbackDispatcher: ${inputData!['userId']}");
    print("Native called background task:"); //simpleTask will be emitted here.

    final userId = inputData['userId'];
    return _getReportsStream(userId);
    // final user = FirebaseAuth.instance.currentUser;
    //   print("user: ${user!.uid}");

    // return Future.value(true);
  });
}

Future<bool> _getReportsStream(String userId) async {
  print("getReportsStream called");
  try {
    // final reports = FirebaseFirestore.instance.collection("reports").get();
    // print("reports: $reports");
    return FirebaseFirestore.instance
        .collection("reports")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .listen((event) {
          print("Collection document has been modified");
          for (var change in event.docChanges) {
            if (change.type == DocumentChangeType.modified) {
              _setupLocalNotification(change.doc.id);
              print("Report#${change.doc.id} status has changed.");
            }
          }
        })
        .asFuture()
        .then((value) {
          return Future.value(true);
        })
        .onError((error, stackTrace) {
          print("e: ${error.toString()}");
          return Future.value(false);
        });
  } catch (e) {
    print("error: ${e.toString()}");
    return Future.value(false);
  }
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
  // await Navigator.push(
  //   context,
  //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  // );
}

void onDidReceiveLocalNotification(int a, String? b, String? c, String? d) {}

_setupLocalNotification(String reportId) async {
  final localNotifications = FlutterLocalNotificationsPlugin();
  const androidInitSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  // const initializationSettingsDarwin = DarwinInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  // const initializationSettingsLinux =
  //     LinuxInitializationSettings(defaultActionName: 'Open notification');

  const initSettings = InitializationSettings(
    android: androidInitSettings,
  );

  await localNotifications.initialize(initSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  String notificationBody = "Report#${reportId.substring(0, 8)} status has been updated.";
  await localNotifications.show(
    0,
    'Call Away',
    notificationBody,
    notificationDetails,
    payload: 'item x',
  );
}

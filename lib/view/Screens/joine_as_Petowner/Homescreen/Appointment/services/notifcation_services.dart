import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../modal/appoint_modal.dart';

class NotificationService extends GetxService {
  late FirebaseMessaging _firebaseMessaging;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  @override
  void onInit() {
    super.onInit();
    _firebaseMessaging = FirebaseMessaging.instance;
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        _showNotification(notification);
      }
    });
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }

  Future<void> sendNotification(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=BMFFKcTdd0d_qXAARdvxrvyiO8cTD1X9VeXMpp_WO6Mw1dC-c2cNeHgODnAwtXEMSwanYI-N1rJ6zi0wypKfhWk', // Replace with your FCM server key
        },
        body: constructFCMPayload(title, body),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully.');
      } else {
        print('Failed to send notification.');
      }
    } catch (e) {
      print('Exception in sending notification: $e');
    }
  }

  String constructFCMPayload(String title, String body) {
    return '''
    {
      "to": "/topics/all",
      "notification": {
        "title": "$title",
        "body": "$body"
      }
    }
    ''';
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addBooking(Booking booking) async {
    await _db.collection('bookings').add(booking.toMap());
  }
}

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import '/src/models/notification_model.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// [Request] - [Notification] - [Permission] from device
  Future<void> requestPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      provisional: true,
      criticalAlert: true,
      sound: true,
    );

    /// Granted - Permission
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      dev.log('Permisson Granted');

      /// Granted  Provisonal  (Access)  Permission
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      dev.log('User granted provisoanl permissions');

      /// Permission Denied
    } else {
      dev.log('User declined or has not accepted permission');
    }
  }

  /// Initializing [Flutter] - [Local] - [Notifications] - [Plugin]
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    /// Foreground Notification Handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      dev.log(
          'Received message while in foreground: ${message.notification?.title}');
      _showNotification(message);
    });

    /// Background - Notification Handling in [main.dart]

    /// OnTap - Notification Handling
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      dev.log('Message Tapped! ${message.notification?.title}');
      _showNotification(message);
    });
  }

  /// Show [Notification]s on Device
  Future<void> _showNotification(RemoteMessage message) async {
    int notificationId = generateRandomId();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "pushnotificationapp",
      "pushnotificationappchannel",
      importance: Importance.max,
      playSound: true,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      // sound: RawResourceAndroidNotificationSound('notification_sound'), // Uncomment for custom sound
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  /// Enable [AutoInit] - [Notifications] for Platforms
  Future<void> enableAutoInit() async {
    if (Platform.isAndroid) {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
    }
  }

  /// Generate [Access] - [Token] for Notification request
  static Future<String> getAccessToken() async {
    // dev.log('Fetching access token...');

    final Map<String, dynamic> serviceToken = {
      // "type": "service_account",
      // "project_id": "cop-cup",
      // "private_key_id": "ceb1c623bb35eebc5698e765dae4a1316b112697",
      // "private_key":
      //     "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDaj2klIJmC2qD0\nxR3GuSOlNkDUUyUEMgsUBimAYlSSfIBdoizpMXUUH6/9bJX+kSAVvHHkQSlGtaKr\nmUuIbaqObT/dyhmqK0frQj9+FQKCedTppKEfoi42Pl4S8ZU9ka7s6LB6SNQlNrby\nXMltdklZzaW6DaEg71O5bWrZYn4QprFTVlg6oVajXmgEMP8uo/+R3o4YtyQoLwKy\n5W83bDbR3K99UKLpE2C4rd+k2uQKf9g434IrvLalJYkeCt2CwheE1w5zU/4jiJ9i\nCpcZagEXBZyD2R03iRq/Racz+tZSS7OvezR7PwxUuAvuaGRamH2fB2jHuhcFsQV8\n4CpANiabAgMBAAECggEAGDn6VTe6XHNgkRFCfjMqfNc5M2/t8/uaF8OhGQ6NQlmT\nnw1pfgXR7QOgLe6556htjos/cqY4bZKXr/7DjSFe3P/GKw8Kbj7y72R+BjtM9mqL\ny8RIaem/xpp+MgpeWR9LbQ5T9ZIaFe/tMotPdpc8hTxS6P82w6BTvwOeau9MewrS\nv3+TUtjw6h31iHuJMsJvR8hRA0XSHbK3nEY91DPqBFfMEzKMy1E8mX80pPZa7G2J\nzrO8x635pRLehGNXxZJ+JL+x4SHRAi6R6pYdReXnS5dzpugJdnDMVL5f0r8mG8vD\ns3UQ4mFdOKvM9cHSUClZyT83LieGQ/CqakP42S9sKQKBgQDtHNnl5v7pQZvkBTXz\nNqi7ty5DJusFM3xYrPTt0v25VPXY0/pQXju3rKCTw9Flv3F/ycEGyUkiX42rHdjt\nv/C0pxFv87U1XopvD2XLO2czPvsck/QUfEEMmoQdWFeIMJESl9utmpPAmuqs+ygH\ntippF+q9zGi6Ya1g6rjp6SoJqQKBgQDr+D251ML6zCLEnED0zkC4rzMBLzDpLdzj\nZNz/HMxKfJvVVxU8FOS8vOj6C9F7zH5P07owoEnYAEsllNv/nzdhYLGZLvMFK7Jd\n4ekLFkzoHYr+S2xuJxaxNu67NQZaGP53U0HY5nmWHavV5nwSx7eKHqk1ANNdVEBQ\nOgo+siIAowKBgQDN77jwjGfpfyo+KKhqzJZQMxDjEfIdWlItUkqIJDBpvvinkbRe\nCPok1LHCpNhBXrzdGAWmNzxltkf8zreSBpqwzEnAyhIggDQLsXvfv4AqahD/CSF8\niU6V+72zHv8nMcdONsZ9STv6lJIuGxTxXa4ICNXAcsCi4CMNgc+ImRIBwQKBgQDM\nKn09zFjnprhuZMPPDKXzJaN74tju6D+2gA62rLQVvrsWW8KDuZAvvUPXFWKrOsQP\nTaJLcGRz/80FN0ciZSAFoSQI5hZe4u/xSwXYEfN44hbg72Fh7XA05NKqJ7bXPcju\ndZsDkGai/AkxibrQhPzJBL5indRDbCI5R/6VQIsrAQKBgQCP046UZxuvQ8NjjETT\n09rWZLQsw02om9CuwFzAVP/LYK9/btioUkNs858oAa9YFZjiDBCX6o+w7ylVMjWP\nM9SIhPiRHjwtJd+Jk3FyDeZFc3+18/wSjhHfj49K/Z3TqpMtzusbZ48Q88uDzopb\nWMG11AvPh4QEb+RWg00nPgprzg==\n-----END PRIVATE KEY-----\n",
      // "client_email": "firebase-adminsdk-ju94r@cop-cup.iam.gserviceaccount.com",
      // "client_id": "110066735937973552897",
      // "auth_uri": "https://accounts.google.com/o/oauth2/auth",

      // "token_uri": "https://oauth2.googleapis.com/token",
      // "auth_provider_x509_cert_url":
      //     "https://www.googleapis.com/oauth2/v1/certs",
      // "client_x509_cert_url":
      //     "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ju94r%40cop-cup.iam.gserviceaccount.com",
      // "universe_domain": "googleapis.com"
      "type": "service_account",
      "project_id": "cop-cup",
      "private_key_id": "d0e230bea00bd4ebd53fe4fdb0d5c84346486756",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC8R3r8Wx+VwgAl\nod+0+gzE+G7DLjy1dPe2OBqlgTIjO9PDe15AkpYobzJkgVtuMavqcdGoFLusvHkf\n3JP9LNzbH+ypVzu9wdNFgIcs7lorjL71Ac1M+4ueKkld/khjSYqUglPBs0AAtROO\nMnpPW4fVn4SqjJfuxnqtD6TZPovZe/NWb4MxxF+abo40Ea+d75e3vSdwpGHo1tty\nRJq6i7U3hlMsSz8YOvgBSrED8NvF6IELayp+2MZ+2t2BLnacamN1xxhThoeDDjo0\nPn6LIdLa4/9ApHPpbVkK/C6SYTSke3024WNogQmSvd7Eq3nMlcAdzBO/1HjXTbRi\nNCuE/rL9AgMBAAECggEAFdS39vDd7bBr8fEeDk78Eg64URtYYLXqTw+cT1p2pM04\nFa+FUzlr/c4+6pZxMorB41JFPBcDV9kWtlIOOsnr5eCCwXPi8nK5+5IWmmgcvnX4\nYlJOKsH0A2flz+c/H3wUfHnMGmadYjecx90kf3Uef++aI2hf6YjMCqsIs0PkVVgt\nq8Poj2SE1tZ50MZon7EvN2MhCOpTByaDdDbwHUBCJt+vvwxCNW39AGtCcjwK1GvL\nlumQM94e3/ZrL+t6yB1LJy9lu38FdXS7Kd1Parn7QYlo0xrMxYhRFhVK0JmBbrnQ\nmFUyiYGciGQU4ETZZNOQpspqBZGKIpxXIuhDxDot4QKBgQD3nrDxvtKtSb0Xp0vw\nRn3LyVpFRwQ54LUi7e8g76sSNQ1ufDAR9EdxjTyrtHR/Sz2yj3ldwMVY1ySler2y\nsFoID/sh6SGewaBVM/M0SzJxMcMwjyDjO3gvkdZf6Va9zcvd8+0bjyGrwBZ8lqpo\nf+dF5685WRWMYMPxoiSnTUWttQKBgQDCpq2t30AdqzzYPQ68voEpZd5FTolIoFo6\n3hE2I6sO6PES0Q2xNd3zL8JTr/QfSPSVmAkkYsTOxtSImNQwyKeTil0yc8019DEQ\nz1y7NN8thuDJa7ClDMnIrBsZA8mLjKFLK3JQcx9bVG98LO91s98KUcTUvgOf83kp\nJ8ZBMcL9KQKBgChmzw4SiYNWpbCnTj+c8MeASedFyA29eTCCy+J+2FW3LELbpmg3\niDShy8VkQyHF4AIzYKUIX+q357XMSglOttHb8ai9xguGIifkuwjMQCWx7dwNbltF\nB74TOHwbsVh0rI/BTe2SM/c29zRKzPER9WU1gSSFQXvPCglx4DMf63+FAoGAXNYU\nNb4pnTzjexq74adWgQEV3qZTcbEQ98ycFt8yIZ1WBSxxxFg1sFvR6goce6NXC9YE\nXjdBOIG6Mh/56/53djXit0Jl2FrL4AGWb68K1nLi2Q4kpMORpcT385lL0ePTtb9V\n+Sq/BNcjiO0BlHiiYxCWuQSbQ/liiw9uTf/GyOkCgYEA4Bkw/CVDzHNztRrJY3sw\nbSDQ0iyM/pR3B2G0bkpRbgw0JU2QOffq60T9FiXAu54I0oD437LXw8nZ6v0Wc0Aa\nN5DZmAp+539bauJVbJDr2PbPNpMLhYOWThAEn3JAXn8DS4jsvJeZyNLG2nERJIFa\nvDC+h2mop0NBwRGakCTG2Ek=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-ju94r@cop-cup.iam.gserviceaccount.com",
      "client_id": "110066735937973552897",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-ju94r%40cop-cup.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };

    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging'
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceToken), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceToken),
              scopes,
              client);

      client.close();
      dev.log(
          'Access token fetched successfully: ${credentials.accessToken.data}');
      return credentials.accessToken.data;
    } catch (e) {
      dev.log('Error fetching access token: $e');
      throw Exception('Failed to fetch access token');
    }
  }

  /// [Send] - [Notification]
  static Future<void> sendNotification(
    String deviceToken,
    BuildContext context,
    String title,
    String userMessage,
  ) async {
    dev.log('Preparing to send notification...');
    final String serverAccessTokenKey = await getAccessToken();
    dev.log('Server access token: $serverAccessTokenKey');

    String endpointFirebaseCloudMessaging =
        'https://fcm.googleapis.com/v1/projects/cop-cup/messages:send';

    final MessageModel message = MessageModel(
      token: deviceToken,
      notification: NotificationModel(
        title: title,
        body: userMessage,
      ),
    );

    try {
      final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessTokenKey'
        },
        body: jsonEncode({
          'message': message.toJson(),
        }),
      );

      if (response.statusCode == 200) {
        dev.log('Notification sent successfully: ${response.body}');
      } else {
        dev.log('Error sending notification: ${response.body}');
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      dev.log('Exception occurred while sending notification: $e');
      throw Exception('Failed to send notification');
    }
  }

  /// [Send] - [Notification] to [Topic]
  Future<void> sendNotificationToTopic(
      {required String notificationTopic, String? title, String? body}) async {
    dev.log('Preparing to send notification...');
    final String serverAccessTokenKey = await getAccessToken();
    dev.log('Server access token: $serverAccessTokenKey');

    const url = 'https://fcm.googleapis.com/v1/projects/cop-cup/messages:send';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverAccessTokenKey',
    };

    final data = {
      "message": {
        "topic": notificationTopic,
        "notification": {"title": title ?? "Notification", "body": body ?? ""},
        "data": {"key1": "value1", "key2": "value2"}
      }
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        dev.log('Notification sent successfully: ${response.body}');
      } else {
        dev.log('Error sending notification: ${response.body}');
        throw Exception('Failed to send notification');
      }
    } catch (e) {
      dev.log('Exception occurred while sending notification: $e');
      throw Exception('Failed to send notification');
    }
  }
}

int generateRandomId() {
  final Random random = Random();
  return random.nextInt(1000000);
}

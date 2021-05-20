import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'authenticate/tabpage.dart';
import 'models/user.dart';
import 'services/auth.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Wrapper(),
  ));
}

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      // if (message != null) {
      //   Navigator.pushNamed(context, '/message',
      //       arguments: MessageArguments(message, true));
      // }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {}
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<LoginUser>.value(
      value: AuthService().fireUser,
      builder: (context, child) {
        final loginuser = Provider.of<LoginUser>(context);
        if (loginuser == null) {
          return Authenticate();
        } else {
          return TabPage();
        }
      },
      initialData: null,
    );
  }
}

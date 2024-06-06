import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chats/messages.dart';
import '../widgets/chats/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.white,
            ),
            label: const Text(
              "Log out",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
    );
  }
}

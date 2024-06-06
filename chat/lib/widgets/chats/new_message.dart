import 'package:chat/helpers/get_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  static final _key = GlobalKey<FormState>();
  static final _controller = TextEditingController();

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  User? user;
  // ignore: prefer_typing_uninitialized_variables
  late final userData;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        user = FirebaseAuth.instance.currentUser;
        userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
      },
    );
    super.initState();
  }

  void _send() {
    NewMessage._key.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: NewMessage._key,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: TextFormField(
                  controller: NewMessage._controller,
                  textCapitalization: TextCapitalization.sentences,
                  decoration:
                      const InputDecoration(labelText: "Xabar yuboring..."),
                  onSaved: (newValue) async {
                    if (newValue != null && newValue.trim().isNotEmpty) {
                      NewMessage._controller.clear();
                      String time = await getTime();
                      FirebaseFirestore.instance.collection("/chats").add(
                        {
                          'text': newValue,
                          'createdAt': Timestamp.fromDate(DateTime.parse(time)),
                          "userId": user!.uid,
                          'username': userData['username'],
                          "image": userData['image'],
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            IconButton(
              onPressed: _send,
              icon: Icon(
                Icons.send_rounded,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

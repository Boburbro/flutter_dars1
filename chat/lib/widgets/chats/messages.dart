import 'package:chat/widgets/chats/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(8.0),
              child: MessageBubble(
                message: docs[i]['text'],
                username: docs[i]['username'],
                isMe: docs[i]['userId'] == user!.uid,
                key: ValueKey(docs[i].id),
              ),
            ),
          );
        }
        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}

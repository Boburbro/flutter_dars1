import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.username,
    required this.imageUrl,
    required this.userId,
    required this.isMe,
    super.key,
  });

  final String message;
  final String username;
  final String userId;
  final String imageUrl;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final image = imageUrl;
    return Row(
      mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        const SizedBox(width: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 16),
            ),
            color: isMe
                ? Colors.green[50]
                : Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(message),
            ],
          ),
        ),
        const SizedBox(width: 5),
        if (isMe)
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}

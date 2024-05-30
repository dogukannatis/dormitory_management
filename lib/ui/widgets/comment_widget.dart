
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String comment;
  final bool canDelete;
  final Function()? onPressed;

  const CommentWidget({super.key,
    required this.username,
    required this.timeAgo,
    required this.comment,
    required this.onPressed,
    this.canDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          child: Icon(Icons.person),
        ),
        const SizedBox(width: 50),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(timeAgo, style: const TextStyle(color: Colors.grey)),
              Text(comment),
            ],
          ),
        ),
        canDelete ?
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete, color: Colors.red,),
        ) : Container()
      ],
    );
  }
}
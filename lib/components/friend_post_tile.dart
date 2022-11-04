import 'package:flutter/material.dart';
import 'package:structureflutter/components/circle_image.dart';
import 'package:structureflutter/models/models.dart';

class FriendPostTile extends StatelessWidget {
  final Post post;

  const FriendPostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleImage(imageProvider: AssetImage(post.profileImageUrl)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.comment),
              Text(
                '${post.timestamp} mins ago',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        )
      ],
    );
  }
}

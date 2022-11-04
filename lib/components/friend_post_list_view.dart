import 'package:flutter/material.dart';
import 'package:structureflutter/components/components.dart';
import 'package:structureflutter/models/models.dart';

class FriendPostListView extends StatelessWidget {
  final List<Post> posts;

  const FriendPostListView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Socials Chefs',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final post = posts[index];
              return FriendPostTile(post: post);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: posts.length,
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}

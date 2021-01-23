import '../Models/Post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  PostCard({
    @required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('${post.violation}'),
          Text('${post.description}'),
          Text('(${post.longitude}), (${post.longitude})'),
          Text('${post.uploadTime}'),
          Text('${post.numberPlate}'),
        ],
      ),
    );
  }
}

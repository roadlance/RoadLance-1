import 'package:flutter/material.dart';
import '../Models/Post.dart';

class PostDisplay extends StatefulWidget {
  PostDisplay({
    @required this.post,
  });

  final Post post;

  @override
  _PostDisplayState createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

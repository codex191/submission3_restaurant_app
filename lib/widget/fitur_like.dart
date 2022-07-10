import 'package:like_button/like_button.dart';
import 'package:flutter/material.dart';

class Like_Button extends StatefulWidget {
  @override
  State<Like_Button> createState() => _Like_ButtonState();
}

class _Like_ButtonState extends State<Like_Button> {
  final isLiked = false;
  int likeCount = 8;
  
  @override
  Widget build(BuildContext context) {
    final double size = 35;

    return LikeButton(
      size: size,
      isLiked: isLiked,
      likeCount: likeCount + 1,
    );
  }
}
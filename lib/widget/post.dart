import 'package:developers/style/container.dart';
import 'package:developers/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:portakal/portakal.dart';

class Post extends StatelessWidget {
  final String image;
  final String username;
  final String bio;
  final String text;
  final String likeCount;

  const Post({
    super.key,
    required this.image,
    required this.username,
    required this.bio,
    required this.text,
    required this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(8),
      decoration: containerStyle(),
      width: PageDetails.postWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    p(context, username, size: 16),
                    p(context, bio, size: 12),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Icon(PhosphorIconsBold.dotsThree),
              SizedBox(width: 8),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: p(context, text, size: 16)),
                Row(
                  children: [
                    Icon(PhosphorIconsDuotone.heart, size: 22),
                    SizedBox(width: 4),
                    subP(context, likeCount),
                    SizedBox(width: 10),
                    Icon(PhosphorIconsDuotone.arrowBendDownRight, size: 22),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

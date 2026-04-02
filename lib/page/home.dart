import 'package:developers/class/images.dart';
import 'package:developers/style/container.dart';
import 'package:developers/utils/size.dart';
import 'package:developers/widget/post.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:portakal/portakal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PManagerScaffold(
      listenables: [],
      backgroundColor: background,
      body: () {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      h2(context, "Developer's"),
                      SizedBox(width: 200),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(PhosphorIconsDuotone.house),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(PhosphorIconsDuotone.mailbox),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(PhosphorIconsDuotone.briefcase),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(PhosphorIconsDuotone.user),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(4),
              width: PageDetails.postWidth(context),
              decoration: containerStyle(),
              child: Column(
                children: [
                  PortakalTextField(
                    text: "Bugün ne düşünüyorsun?",
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(
                          PhosphorIconsDuotone.city,
                          size: 22,
                          color: textColor.withOpacity(0.8),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          PhosphorIconsDuotone.calendar,
                          size: 22,
                          color: textColor.withOpacity(0.8),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          PhosphorIconsDuotone.image,
                          size: 22,
                          color: textColor.withOpacity(0.8),
                        ),
                        SizedBox(width: 6),
                        Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: defaultColor,
                            borderRadius: BorderRadius.circular(1020),
                          ),
                          child: p(context, "Gönder"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Post(
              image: image,
              username: "JeaFriday",
              bio: "BİOOO",
              text: "text",
              likeCount: "10",
            ),
            Post(
              image: image,
              username: "JeaFriday",
              bio: "BİOOO",
              text: "text",
              likeCount: "10",
            ),
            Post(
              image: image,
              username: "JeaFriday",
              bio: "BİOOO",
              text: "text",
              likeCount: "10",
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';

class PageDetails {
  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double postWidth(BuildContext context) {
    if (width(context) < 550) {
      return width(context) - 16;
    } else if (width(context) < 1200) {
      return 550 - 16;
    } else {
      return 750 - 16;
    }
  }

  static int postCount(BuildContext context) {
    if (width(context) < 550) {
      return 1;
    } else if (width(context) < 1200) {
      return 2;
    } else {
      return 3;
    }
  }
}

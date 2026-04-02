// ignore_for_file: unused_local_variable

import 'package:developers/main.dart';
import 'package:developers/page/home.dart';
import 'package:developers/page/login.dart';
import 'package:developers/page/register.dart';
import 'package:developers/utils/snack.dart';
import 'package:flutter/material.dart';

class JeaPageData {
  final String route;
  const JeaPageData(this.route);
}

enum JeaPage {
  home(JeaPageData("/")),
  nodexy(JeaPageData("/nodexy")),
  profile(JeaPageData("/profile")),
  post(JeaPageData("/post")),
  add(JeaPageData("/add")),
  settingsProfile(JeaPageData("settings/profile")),
  login(JeaPageData("/login")),
  register(JeaPageData("/register"));

  final JeaPageData data;
  const JeaPage(this.data);

  static Route<dynamic> onGenerate(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? "/");
    final segments = uri.pathSegments;

    return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) {
        return _path(segments);
      },
    );
  }

  static Widget _path(List<String> segments) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (segments.isEmpty) {
            return HomePage();
          } else {
            var s = segments[0];
            var s1 = segments.length > 1 ? segments[1] : null;
            var s2 = segments.length > 2 ? segments[2] : null;
            var s3 = segments.length > 3 ? segments[3] : null;
            if (myProfile == null) {
              switch (s) {
                case "login":
                  return LoginPage();
                case "register":
                  return RegisterPage();

                default:
                  return HomePage();
              }
            } else {
              return HomePage();
            }
          }
        },
      ),
    );
  }
}

Future<Object?> push(
  BuildContext context,
  JeaPage page, {
  String? subRoute,
  Object? arguments,
}) {
  String path = page.data.route;
  if (subRoute != null) {
    path = path.endsWith("/") ? "$path$subRoute" : "$path/$subRoute";
  }
  return Navigator.pushNamed(context, path, arguments: arguments);
}

void pop(BuildContext context) {
  closeAllToasts();
  Navigator.pop(context);
}

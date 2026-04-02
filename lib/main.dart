import 'dart:async';
import 'package:developers/env/env.dart';
import 'package:developers/utils/page.dart';
import 'package:developers/utils/uid.dart';
import 'package:developers/utils/user_datas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portakal/portakal.dart';
import 'package:zeytin/zeytin.dart';

void loadingSysManager(bool value) {
  loadingSys.set(value);
}

ZeytinClient zeytin = ZeytinClient();
PManager<bool> loadingSys = PManager(false);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
List<ZeytinUserModel> cacheUsers = [];
ZeytinUserModel? myProfile;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Portakal.init(
    setFontBuilder: (style) => GoogleFonts.poppins(textStyle: style),
    setDarkTheme: PortakalThemeData(
      background: Colors.black,
      defaultColor: Colors.indigoAccent,
      textColor: textColor,
      cardColor: cardColor,
      secondCardColor: secondCardColor,
    ),
  );
  await zeytin.init(
    host: Env.zeytinHost,
    email: Env.zeytinEmail,
    password: Env.zeytinPassword,
  );
  await UsersDatabase.getUser();
  String? uid = await getUID();
  if (uid != null) {
    var profile = UsersDatabase.getUserWithUID(uid: uid);
    if (profile != null) {
      myProfile = profile;
    }
  }
  runApp(Developers(isSignIn: myProfile != null));
  Timer.periodic(Duration(seconds: 20), (timer) async {
    String? myUID = await getUID();
    if (myUID == null) return;
    if (myProfile == null) return;
    await ZeytinUser(zeytin).updateUserActive(myProfile!);
  });

  zeytin.watchBox(box: "users").listen((event) {
    var user = ZeytinUserModel.fromJson(event["data"]);
    bool isContain = cacheUsers.any((element) => user.uid == element.uid);
    if (!isContain) {
      cacheUsers.add(user);
    } else {
      int index = cacheUsers.indexWhere((element) => user.uid == element.uid);
      cacheUsers[index] = user;
    }
  });
}

class Developers extends StatefulWidget {
  final bool isSignIn;
  const Developers({super.key, required this.isSignIn});

  @override
  State<Developers> createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JeaFriday Developer's",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStateProperty.all(false),
          thickness: WidgetStateProperty.all(0),
          interactive: false,
        ),
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: defaultColor,
          brightness: Brightness.dark,
        ),
      ),
      builder: (context, child) {
        return PManagerListener(
          listenables: [],
          childBuilder: () {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                child!,
                AnimatedVisibility(
                  visible: loadingSys(),
                  child: Container(
                    color: background.withOpacity(0.5),
                    width: PortakalWindow.width(context),
                    height: PortakalWindow.height(context),
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                ),
              ],
            );
          },
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('tr', 'TR')],
      initialRoute: widget.isSignIn ? JeaPage.home.name : JeaPage.login.name,
      onGenerateRoute: JeaPage.onGenerate,
      home: SizedBox(),
    );
  }
}

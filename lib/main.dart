import 'package:developers/env/env.dart';
import 'package:developers/page/home.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: HomePage(),
    );
  }
}

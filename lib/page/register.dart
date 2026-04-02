import 'package:developers/class/auth_var.dart';
import 'package:developers/class/buttons.dart';
import 'package:developers/main.dart';
import 'package:developers/utils/page.dart';
import 'package:developers/utils/size.dart';
import 'package:developers/utils/snack.dart';
import 'package:developers/utils/uid.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:portakal/portakal.dart';
import 'package:zeytin/zeytin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return PManagerScaffold(
      listenables: [],
      backgroundColor: background,
      body: () {
        double width = PageDetails.postWidth(context) * 0.8;
        return Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            h2(context, "Developer's"),
                            p(
                              context,
                              "Seçkin Mühendislerin Evine Hoş Geldin!",
                            ),
                          ],
                        ),
                      ),
                      AuthVar.textbox(width, AuthFieldType.user),
                      AuthVar.textbox(width, AuthFieldType.email),
                      AuthVar.textbox(width, AuthFieldType.password),
                      Buttons.sendButton(context, "Kayıt Ol", false, () async {
                        await _register();
                      }),
                      p(context, "VEYA"),
                      Buttons.sendButton(context, "Giriş Yap", true, () async {
                        push(context, JeaPage.login);
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: subP(
                context,
                "JeaFriday Developer's | 2026",
                color: textColor.withOpacity(0.2),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _register() async {
    try {
      var name = AuthVar.user.text.trim();
      var email = AuthVar.email.text.trim();
      var password = AuthVar.password.text.trim();
      if (name.length > 5 &&
          email.contains("@") &&
          email.length > 6 &&
          password.length > 6) {
        var res = await ZeytinUser(zeytin).create(name, email, password);
        if (res.isSuccess) {
          var data = res.data;
          if (data == null) return;
          var user = ZeytinUserModel.fromJson(data);
          myProfile = user;
          await setUID(user.uid);
          if (mounted) {
            push(context, JeaPage.home);
          }
        } else {
          if (mounted) {
            showToast(
              context,
              PhosphorIconsDuotone.sealWarning,
              res.error ?? res.message,
            );
          }
        }
      } else {
        showToast(
          context,
          PhosphorIconsDuotone.sealWarning,
          "Tüm bilgileri doğru girdiğinizden emin olun.",
        );
      }
    } catch (e) {
      if (mounted) {
        showToast(context, PhosphorIconsDuotone.sealWarning, e.toString());
      }
    }
  }
}

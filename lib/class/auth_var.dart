import 'package:developers/style/container.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:portakal/portakal.dart';

enum AuthFieldType {
  user(),
  email(),
  password();

  const AuthFieldType();
}

class AuthVar {
  static var user = TextEditingController();
  static var email = TextEditingController();
  static var password = TextEditingController();
  static Widget textbox(double width, AuthFieldType type) {
    PManager<bool> onEnterEye = PManager(false);
    PManager<bool> passwordVisib = PManager(false);
    return PManagerListener(
      listenables: [onEnterEye, passwordVisib],
      childBuilder: () {
        return MouseRegion(
          onEnter: (event) => onEnterEye.set(true),
          onExit: (event) => onEnterEye.set(false),
          child: Container(
            width: width,
            margin: EdgeInsets.all(4),
            decoration: containerStyle(),
            child: Row(
              children: [
                SizedBox(width: 14),
                Icon(
                  type == AuthFieldType.email
                      ? PhosphorIconsDuotone.envelope
                      : type == AuthFieldType.user
                      ? PhosphorIconsDuotone.user
                      : type == AuthFieldType.password
                      ? PhosphorIconsDuotone.key
                      : PhosphorIconsDuotone.user,
                ),
                Expanded(
                  child: PortakalTextField(
                    obscureText: type == AuthFieldType.password
                        ? !passwordVisib()
                        : false,
                    textController: type == AuthFieldType.email
                        ? email
                        : type == AuthFieldType.user
                        ? user
                        : type == AuthFieldType.password
                        ? password
                        : user,
                    text: type == AuthFieldType.email
                        ? "E-Posta"
                        : type == AuthFieldType.user
                        ? "Kullanıcı Adı"
                        : type == AuthFieldType.password
                        ? "Parola"
                        : "Kullanıcı Adı",
                    maxLines: 1,
                    keyboardType: type == AuthFieldType.email
                        ? TextInputType.emailAddress
                        : type == AuthFieldType.user
                        ? TextInputType.name
                        : type == AuthFieldType.password
                        ? TextInputType.visiblePassword
                        : TextInputType.name,
                  ),
                ),
                if (type == AuthFieldType.password)
                  PortakalPressable(
                    onTap: () {
                      passwordVisib.set(!passwordVisib());
                    },
                    child: AnimatedOpacity(
                      opacity: onEnterEye() ? 1 : 0.5,
                      duration: Durations.medium1,
                      child: Row(
                        children: [
                          Icon(
                            passwordVisib()
                                ? PhosphorIconsDuotone.eye
                                : PhosphorIconsDuotone.eyeClosed,
                            color: textColor,
                          ),
                          SizedBox(width: 14),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

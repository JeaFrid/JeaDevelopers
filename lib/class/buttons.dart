import 'package:developers/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:portakal/portakal.dart';

class Buttons {
  static Widget sendButton(
    BuildContext context,
    String text,
    bool bgClear,
    Future<void> Function() onTap,
  ) {
    double width = PageDetails.postWidth(context) * 0.8;
    PManager<bool> onEnter = PManager(false);
    PManager<bool> onEnterHover = PManager(false);
    return PManagerListener(
      listenables: [onEnter, onEnterHover],
      childBuilder: () {
        return MouseRegion(
          onEnter: (event) => onEnterHover.set(true),
          onExit: (event) => onEnterHover.set(false),
          child: GestureDetector(
            onTapDown: (details) => onEnter.set(true),
            onTapCancel: () => onEnter.set(false),
            onTap: () async {
              await onTap();
              onEnter.set(false);
            },
            child: Container(
              width: width,
              alignment: Alignment.center,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                border: onEnter()
                    ? null
                    : Border(
                        bottom: BorderSide(
                          width: 2,
                          color: !onEnterHover()
                              ? textColor.withOpacity(0.05)
                              : textColor.withOpacity(0.2),
                        ),
                        right: BorderSide(
                          width: 2,
                          color: !onEnterHover()
                              ? textColor.withOpacity(0.05)
                              : textColor.withOpacity(0.2),
                        ),
                      ),
                color: bgClear
                    ? Colors.transparent
                    : cardColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(1020),
              ),
              child: !bgClear ? bold(context, text) : p(context, text),
            ),
          ),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';
import 'package:portakal/portakal.dart';

PortakalDeviceType responsiveMaxWidth(BuildContext context) {
  if (PortakalWindow.width(context) < 600) {
    return PortakalDeviceType.isMobile;
  } else if (PortakalWindow.width(context) < 900) {
    return PortakalDeviceType.isTablet;
  } else {
    return PortakalDeviceType.isDesktop;
  }
}

void closeAllToasts() {
  DelightToastBar.removeAll();
}

BuildContext? showToast(
  BuildContext context,
  IconData icon,
  String text, {
  String? actionLabel,
  Future<void> Function()? onAction,
}) {
  if (!context.mounted) return null;

  final overlayContext = Navigator.of(
    context,
    rootNavigator: true,
  ).overlay?.context;
  if (overlayContext == null) return null;

  final hasAction = actionLabel != null && onAction != null;
  final title = p(context, text);
  WidgetsBinding.instance.scheduleFrame();

  DelightToastBar(
    autoDismiss: !hasAction,
    builder: (ctx) {
      return Row(
        mainAxisAlignment:
            responsiveMaxWidth(context) == PortakalDeviceType.isDesktop
            ? MainAxisAlignment.end
            : MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: responsiveMaxWidth(context) == PortakalDeviceType.isDesktop
                ? 300
                : PortakalWindow.width(context) * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: secondCardColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: cardColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: defaultColor.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: defaultColor),
                const SizedBox(width: 10),
                Expanded(child: title),
                if (hasAction) ...[
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () async {
                      DelightToastBar.removeAll();
                      await onAction.call();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: defaultColor,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(0, 34),
                    ),
                    child: Text(
                      actionLabel,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    },
  ).show(context);

  return context;
}

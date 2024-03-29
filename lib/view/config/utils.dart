import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text, Color color) {
    if (text == null) {
      return;
    }
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.startToEnd,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showAlertDialogBox(BuildContext ctx, String title, String message, VoidCallback onTapConfirm) {
   PanaraConfirmDialog.show(
    ctx, 
    title: title,
    message: message,
    confirmButtonText: "Confirm",
    cancelButtonText: "Cancel",
    color: const Color(0xff388E3C),
    onTapCancel: () {
      Navigator.pop(ctx);
    },
    onTapConfirm: onTapConfirm,
    panaraDialogType: PanaraDialogType.custom,
    barrierDismissible: true, // optional parameter (default is true)
);
  }
}

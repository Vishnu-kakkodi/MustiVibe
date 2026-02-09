// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class ToastUtils {
//   // Success toast
//   static void showSuccess(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 14.0,
//     );
//   }

//   // Error toast
//   static void showError(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 3,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 14.0,
//     );
//   }

//   // Info toast
//   static void showInfo(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.blue,
//       textColor: Colors.white,
//       fontSize: 14.0,
//     );
//   }

//   // Warning toast
//   static void showWarning(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.orange,
//       textColor: Colors.white,
//       fontSize: 14.0,
//     );
//   }

//   // Custom toast
//   static void showCustom({
//     required String message,
//     Color? backgroundColor,
//     Color? textColor,
//     Toast? length,
//     ToastGravity? gravity,
//   }) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: length ?? Toast.LENGTH_SHORT,
//       gravity: gravity ?? ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: backgroundColor ?? Colors.grey.shade800,
//       textColor: textColor ?? Colors.white,
//       fontSize: 14.0,
//     );
//   }
// }














import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  // Success toast
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // Error toast
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // Info toast
  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // Warning toast
  static void showWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  // Custom toast
  static void showCustom({
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Toast? length,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length ?? Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor ?? Colors.grey.shade800,
      textColor: textColor ?? Colors.white,
      fontSize: 14.0,
    );
  }
}
// ignore_for_file: unnecessary_import, constant_identifier_names, avoid_print
import 'package:application_1/shop_app/constant/Netowrk/locale/cash_helper.dart';
import 'package:application_1/shop_app/screens/login/shop_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateToFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
// toast

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseTheColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
// to choose the color for toast we neede the enum
enum ToastStates {
  SUCSSES,
  ERROR,
  WORNING,
}
// the methodde to chooose the color for the tost
Color chooseTheColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCSSES:
      color = Colors.green;
      break;
    case ToastStates.WORNING:
      color = Colors.yellow;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

// علشان لما تدوس علي الزرزا يخرج برا التتطبيق
void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateToFinish(context, const ShopLoginScreen());
  });
}

// علشان اقدر اطلع الاكلام كله الي في التتطبيق

void printAllText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach(
        (element) => print(element.group(0)),
      );
}

// طيب هو احنا دلوقتي هنعرف توكن علشان اقدر اسنخدمه ي ال home lyout
//ومنها اقدر احدد المستخدم الخاص بي
String token = '';

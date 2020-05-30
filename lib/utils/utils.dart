import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }
   static void showToast(String msg, {int duration, int gravity}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        textColor: Colors.white,
        fontSize: 14.0
    );
  }

  static String replaceStr(str, frontLen, endLen) {
    if (str == '') {
      return '';
    }
    if (str.length == 1) {
      return str;
    }
    int len = str.length > 2 ? str.length-frontLen-endLen : 1;
    var rStr = '';
    
    for (int i=0; i < len; i++) {
      rStr+='*';
    }
    if (str.length > 2 ) {
       return str.substring(0, frontLen) + rStr + str.substring(str.length - endLen);
    } else {
       return rStr + str.substring(1);
    }
  }

}
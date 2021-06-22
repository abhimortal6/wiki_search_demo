import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:wiki_search/widgets/edge_alert.dart';

class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }

  static Future<bool?> isOnline(BuildContext context, bool showError) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    debugPrint("No Internet");
    if (showError)
      EdgeAlert.show(context,
          title: 'Connectivity Error',
          description: "Please check your internet connection",
          gravity: EdgeAlert.TOP,
          icon: Icons.portable_wifi_off_rounded,
          duration: 4,
          backgroundColor: Colors.grey);
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      if (internet != null && internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}

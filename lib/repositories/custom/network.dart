import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityHelper {
  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static void showNoInternetSnackbar(BuildContext context) {
    // Example of showing a snackbar when no internet connectivity
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("No internet connection"),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ),
    );
  }
}

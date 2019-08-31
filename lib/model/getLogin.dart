import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class GetAdminHomeModel with ChangeNotifier {
  bool isLoading = false;
  List user;
  int index;

  String msg = '';

  var datauser;

  TextEditingController controllerEmail;
  TextEditingController controllerPassword;
  TextEditingController controllerSekolah;

  checkInternetConnectivity(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('No internet'),
            content: Text(
                "You're not connected to a network, Come back when you're online"),
            actions: <Widget>[
              FlatButton(
                child: Text('Exit'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  Future<List> getData() async {
    try {
      final response = await http.get(phone + '/getdata.php');
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String get getmsg => msg;

  set getmsg(String newmsg) {
    msg = newmsg;
    notifyListeners();
  }

  bool get getisLoading => isLoading;

  set getisLoading(bool newLoading) {
    isLoading = newLoading;
    notifyListeners();
  }
}

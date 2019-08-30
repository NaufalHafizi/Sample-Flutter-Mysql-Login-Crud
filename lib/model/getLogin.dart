import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  Future<List> getData() async {
    try {
      final response = await http.get(phone + '/ihadir/getdata.php');
    return json.decode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
    
  }

  String get getmsg => msg;

  set getmsg (String newmsg) {
    msg = newmsg;
    notifyListeners();
  }

  bool get getisLoading => isLoading;

  set getisLoading (bool newLoading) {
    isLoading = newLoading;
    notifyListeners();
  }

  

}
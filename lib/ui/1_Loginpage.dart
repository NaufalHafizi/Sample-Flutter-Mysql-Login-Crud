import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlcrudnlogin/main.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  //"username" yg bawah mesti sama dgn argument di php

  Future<List> _login(BuildContext context) async {
    
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    final response = await http.post(phone + '/ihadir/login.php', body: {
      "username": user.text,
      "password": pass.text,
    });

    adminhomemodel.datauser = jsonDecode(response.body);

    if (adminhomemodel.datauser.length == 0) {
      adminhomemodel.getisLoading = false;
      adminhomemodel.getmsg = 'Login Fail';
    } else {
      adminhomemodel.getisLoading = false;
      if (adminhomemodel.datauser[0]['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/adminhomepage');
      } else if (adminhomemodel.datauser[0]['level'] == 'teacher') {
        Navigator.pushReplacementNamed(context, '/teacherhomepage');
      }
    } return null;
  }

  @override
  Widget build(BuildContext context) {
     var adminhomemodel = Provider.of<GetAdminHomeModel>(context);
    return ModalProgressHUD(
      child: new Scaffold(
        appBar: AppBar(title: Text('LOGIN'),),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 150,),
                    
                    TextField(
                      controller: user,
                      decoration: InputDecoration(
                        hintText: 'Username'
                      ),
                    ),
                    
                    TextField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password'
                      ),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      child: Text('Login'),
                      onPressed: () {
                        adminhomemodel.getisLoading = true;
                        _login(context);
                      },
                    ),

                    Text(adminhomemodel.getmsg, style: TextStyle(fontSize: 20.0, color: Colors.red),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      inAsyncCall: adminhomemodel.getisLoading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
    );
  }
}
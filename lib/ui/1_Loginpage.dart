import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlcrudnlogin/main.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mysqlcrudnlogin/statefulwrapper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  static GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  static TextEditingController user = new TextEditingController();
  static TextEditingController pass = new TextEditingController();

  //"username" yg bawah mesti sama dgn argument di php

  Future<List> _login(BuildContext context) async {
    
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    final response = await http.post(phone + '/login.php', body: {
      "username": user.text,
      "password": pass.text,
    });

    print(response.body);

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
    return StatefulWrapper(
      onInit: () => adminhomemodel.checkInternetConnectivity(context),
          child: ModalProgressHUD(
        child: new Scaffold(
          appBar: AppBar(title: Text('LOGIN'),),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 150,),
                        
                        TextFormField(
                          controller: user,
                          decoration: InputDecoration(
                            hintText: 'Username'
                          ),
                          validator: (value) => value.isEmpty ? 'Email required' : null,
                        ),
                        
                        TextFormField(
                          controller: pass,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password'
                          ),
                          validator: (value) => value.isEmpty ? 'Password required' : null,
                        ),
                        SizedBox(height: 20,),
                        RaisedButton(
                          child: Text('Login'),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              adminhomemodel.getisLoading = true;
                            _login(context);
                            }
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
        ),
        inAsyncCall: adminhomemodel.getisLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(backgroundColor: Colors.purple,),
      ),
    );
  }
}
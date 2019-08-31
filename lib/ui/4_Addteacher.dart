import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlcrudnlogin/main.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:mysqlcrudnlogin/statefulwrapper.dart';
import 'package:provider/provider.dart';

class TeacherAdd extends StatelessWidget {

  static TextEditingController controllerEmail  = new TextEditingController();
  static TextEditingController controllerPassword  = new TextEditingController();
  static TextEditingController controllerSekolah  = new TextEditingController();

  void addData() async {
    var url = '$phone/adddata.php';
  //email tu kena sama dgn php argument
    http.post(url, body: {
      "email": controllerEmail.text, 
      "password": controllerPassword.text,
      "sekolah": controllerSekolah.text
    });
  }

  @override
  Widget build(BuildContext context) {
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);
    return StatefulWrapper(
      onInit: () => adminhomemodel.checkInternetConnectivity(context),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Add Teacher'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new TextField(
                    controller: controllerEmail,
                    decoration: new InputDecoration(
                        hintText: "Email Teacher", labelText: "Email Teacher"),
                  ),
                  new TextField(
                    controller: controllerPassword,
                    decoration: new InputDecoration(
                        hintText: "Password Teacher",
                        labelText: "Password Teacher"),
                  ),
                  new TextField(
                    controller: controllerSekolah,
                    decoration: new InputDecoration(
                        hintText: "Sekolah Teacher",
                        labelText: "Sekolah Teacher"),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    child: new Text("ADD TEACHER"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      addData();
                      Navigator.pushNamedAndRemoveUntil(context, '/adminhomepage', (route)=>false);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

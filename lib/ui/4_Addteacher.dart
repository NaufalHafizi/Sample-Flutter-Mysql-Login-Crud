import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlcrudnlogin/main.dart';

class TeacherAdd extends StatelessWidget {

  TextEditingController controllerEmail  = new TextEditingController();
  TextEditingController controllerPassword  = new TextEditingController();
  TextEditingController controllerSekolah  = new TextEditingController();

  void addData() {
    var url = '$phone/ihadir/adddata.php';
  //email tu kena sama dgn php argument
    http.post(url, body: {
      "email": controllerEmail.text, 
      "password": controllerPassword.text,
      "sekolah": controllerSekolah.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
    );
  }
}

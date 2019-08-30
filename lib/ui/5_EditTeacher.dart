import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlcrudnlogin/main.dart';

class EditTeacher extends StatefulWidget {

  final List user;
  final int index;

  EditTeacher({this.user, this.index});

  @override
  _EditTeacherState createState() => _EditTeacherState();
}

class _EditTeacherState extends State<EditTeacher> {

  TextEditingController controllerEmail;
  TextEditingController controllerPassword;
  TextEditingController controllerSekolah;

  @override
  void initState() {
    controllerEmail = new TextEditingController(text: widget.user[widget.index]['Teacher_email']);
    controllerPassword = new TextEditingController(text: widget.user[widget.index]['Teacher_password']);
    controllerSekolah = new TextEditingController(text: widget.user[widget.index]['Teacher_sekolah']);
    super.initState();
  }

  void editData() async {
    var url = '$phone/editdata.php';

    http.post(url, body: {
      "ID": widget.user[widget.index]['ID'],
      "email": controllerEmail.text,
      "password": controllerPassword.text,
      "sekolah": controllerSekolah.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Edit Details Teacher"),),
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
                child: new Text("EDIT TEACHER"),
                color: Colors.blueAccent,
                onPressed: () {
                  editData();
                  Navigator.pushNamedAndRemoveUntil(context, '/adminhomepage', (route)=>false);
                },
              )
            ],
          ),
        ],
      ),
    )
    );
  }
}
